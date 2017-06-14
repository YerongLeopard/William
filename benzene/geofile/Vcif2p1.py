import os,sys,numpy
from math import radians, sin, cos, sqrt 


def readcif(input):
  lines = open(input).readlines()
  al = []
  bl = []
  cnt = 0
  lenf = len(lines)
  # DEBUG
  for i in range(lenf):
    s = lines[i].split()
    # DEBUG
    if 0 == len(s):
      continue
    if s[0] == '_cell_length_a':
      bl.append(float(s[1]))
    if s[0] == '_cell_length_b':
      bl.append(float(s[1]))
    if s[0] == '_cell_length_c':
      bl.append(float(s[1]))
    if s[0] == '_cell_angle_alpha':
      bl.append(float(s[1]))
    if s[0] == '_cell_angle_beta':
      bl.append(float(s[1]))
    if s[0] == '_cell_angle_gamma':
      bl.append(float(s[1]))
    if s[0] == '_atom_site_type_symbol':
      j = i+1
      line = i+1
      s = lines[j].split()
      while  s[0] != '_':
        # DEBUG
        cnt += 1
        j += 1
        if j >= (len(lines)):
          break
        s = lines[j].split()
  # DEBUG 
  
  for i in range(cnt):
    al.append([])
  for i in range(cnt):
    s = lines[i+line].split()
    al[i].append(float(s[2]))
    al[i].append(float(s[3]))
    al[i].append(float(s[4]))
    al[i].append(s[1])
    al[i].append(s[0])
  return al, bl


def orientc(input,al,bl):
  a = bl[0]
  b = bl[1]
  c = bl[2]
  alpha = radians(bl[3])
  beta = radians(bl[4])
  gamma = radians(bl[5])
  cosphi = (cos(alpha)*cos(beta)-cos(gamma))/(sin(alpha)*sin(beta))
  sinphi = sqrt(1-cosphi**2)
 
  M11 = a*sin(beta)*sinphi
  M21 = -a*cosphi*sin(beta)
  M22 = b*sin(alpha)
  M31 = a*cos(beta)
  M32 = b*cos(alpha)
  M33 = c

  name = '.'.join(input.split('.')[:-1])
  output = name+'.xyz'
  f = open(output,'w')
  f.write('%i \n'%len(al))
  f.write('#CRYSTX      %0.5f %0.5f %0.5f %0.5f %0.5f %0.5f \n'%(a,b,c,bl[3],bl[4],bl[5]))
  for i in range(len(al)):
    X = M11*al[i][0]
    Y = M21*al[i][0] + M22*al[i][1]
    Z = M31*al[i][0] + M32*al[i][1] + M33*al[i][2]
    f.write(al[i][-1]+' %0.5f %0.5f %0.5f \n'%(X,Y,Z))
  f.close()


if __name__=='__main__':
    helpString ="""
        Usage: cif2p1.py file.cif orientation 
        This script converts the .cif file into .xyz with p1 symmetry
        Input:
            file.cif: cif file with fractional coordinates
            orientation:  c or a 
                 c:  C along Z, B in YZ plane (default)
                 a:  A along X, B in XY plane    
    """

    orient = 'c'

    args = sys.argv[1:]
    numArgs = len(args)
    if numArgs == 0:
        print helpString
        sys.exit()
    if numArgs >= 1:
        input = str(args[0])
    if numArgs >= 2:
        orient = args[1]


    al, bl = readcif(input)
    if orient == 'c':
      orientc(input,al,bl)
    else:
      print 'orientation a is not included yet!'
      sys.exit()

