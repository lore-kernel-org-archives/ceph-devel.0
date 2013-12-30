From: Guang <yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Ceph cluster performance degrade (radosgw) after
	running some time
Date: Mon, 30 Dec 2013 19:45:51 +0800
Message-ID: <0F833EEE-60A2-4640-A0D5-ADC1D490E785@yahoo.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/mixed; boundary="===============1124912741=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============1124912741==
Content-Type: multipart/alternative; boundary="Apple-Mail=_6FCF430B-0A61-48D7-95D1-DFB16EB47DF8"


--Apple-Mail=_6FCF430B-0A61-48D7-95D1-DFB16EB47DF8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hi ceph-users and ceph-devel,
Merry Christmas and Happy New Year!

We have a ceph cluster with radosgw, our customer is using S3 API to =
access the cluster.

The basic information of the cluster is:
bash-4.1$ ceph -s
  cluster b9cb3ea9-e1de-48b4-9e86-6921e2c537d2
   health HEALTH_ERR 1 pgs inconsistent; 1 scrub errors
   monmap e1: 3 mons at =
{osd151=3D10.194.0.68:6789/0,osd152=3D10.193.207.130:6789/0,osd153=3D10.19=
3.207.131:6789/0}, election epoch 40, quorum 0,1,2 osd151,osd152,osd153
   osdmap e129885: 787 osds: 758 up, 758 in
    pgmap v1884502: 22203 pgs: 22125 active+clean, 1 =
active+clean+scrubbing, 1 active+clean+inconsistent, 76 =
active+clean+scrubbing+deep; 96319 GB data, 302 TB used, 762 TB / 1065 =
TB avail
   mdsmap e1: 0/0/1 up

#When the latency peak happened, there was no scrubbing, recovering or =
backfilling at the moment.#

While the performance of the cluster (only with WRITE traffic) is stable =
until Dec 25th, our monitoring (for radosgw access log) shows a =
significant increase of average latency and 99% latency.

And then I chose one OSD and try to grep slow requests logs and find =
that most of the slow requests were waiting for subop, I take osd22 for =
example.

osd[561-571] are hosted by osd22.
-bash-4.1$ for i in {561..571}; do grep "slow request" ceph-osd.$i.log | =
grep "2013-12-25 16"| grep osd_op | grep -oP "\d+,\d+" ; done > =
~/slow_osd.txt
-bash-4.1$ cat ~/slow_osd.txt  | sort | uniq -c | sort =96nr
   3586 656,598
    289 467,629
    284 598,763
    279 584,598
    203 172,598
    182 598,6
    155 629,646
     83 631,598
     65 631,593
     21 616,629
     20 609,671
     20 609,390
     13 609,254
     12 702,629
     12 629,641
     11 665,613
     11 593,724
     11 361,591
     10 591,709
      9 681,609
      9 609,595
      9 591,772
      8 613,662
      8 575,591
      7 674,722
      7 609,603
      6 585,605
      5 613,691
      5 293,629
      4 774,591
      4 717,591
      4 613,776
      4 538,629
      4 485,629
      3 702,641
      3 608,629
      3 593,580
      3 591,676

It turns out most of the slow requests were waiting for osd 598, 629, I =
ran the procedure on another host osd22 and got the same pattern.

Then I turned to the host having osd598 and dump the perf counter to do =
comparision.

-bash-4.1$ for i in {594..604}; do sudo ceph --admin-daemon =
/var/run/ceph/ceph-osd.$i.asok perf dump | ~/do_calc_op_latency.pl; done
op_latency,subop_latency,total_ops
0.192097526753471,0.0344513450167198,7549045
1.99137797628122,1.42198426157216,9184472
0.198062399664129,0.0387090378926376,6305973
0.621697271315762,0.396549768986993,9726679
29.5222496247375,18.2888846379615, 10860858
0.229250239525916,0.0557482067611005,8149691
0.208981698303654,0.0375553180438224,6623842
0.47474766302086,0.292583928601509,9838777
0.339477790083925,0.101288409388438,9340212
0.186448840141895,0.0327296517417626,7081410
0.807598201207144,0.0139762289702332,6093531
(osd 598 is op hotspot as well)

This double confirmed that osd 598 was having some performance issues =
(it has around 30 seconds average op latency!).
sar shows slightly higher disk I/O for osd 598 (/dev/sdf) but the =
latency difference is not as significant as we saw from osd perf.
reads   kbread writes  kbwrite %busy  avgqu  await  svctm
37.3    459.9    89.8     4106.9   61.8     1.6       12.2    4.9
42.3    545.8    91.8     4296.3   69.7     2.4       17.6    5.2=20
42.0    483.8    93.1     4263.6   68.8     1.8       13.3    5.1
39.7    425.5    89.4     4327.0   68.5     1.8       14.0    5.3

Another disk at the same time for comparison (/dev/sdb).
reads   kbread writes  kbwrite %busy  avgqu  await  svctm
34.2    502.6    80.1    3524.3    53.4     1.3     11.8      4.7
35.3    560.9    83.7    3742.0    56.0     1.2     9.8       4.7=20
30.4    371.5   78.8     3631.4    52.2     1.7     15.8     4.8
33.0    389.4   78.8      3597.6   54.2     1.4      12.1    4.8

Any idea why a couple of OSDs are so slow that impact the performance of =
the entire cluster?

Thanks,
Guang=

--Apple-Mail=_6FCF430B-0A61-48D7-95D1-DFB16EB47DF8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; ">Hi =
ceph-users and ceph-devel,<div>Merry Christmas and Happy New =
Year!</div><div><br></div><div>We have a ceph cluster with radosgw, our =
customer is using S3 API to access the =
cluster.</div><div><br></div><div>The basic information of the cluster =
is:</div><div><div>bash-4.1$ ceph -s</div><div>&nbsp; cluster =
b9cb3ea9-e1de-48b4-9e86-6921e2c537d2</div><div>&nbsp; &nbsp;health =
HEALTH_ERR 1 pgs inconsistent; 1 scrub errors</div><div>&nbsp; =
&nbsp;monmap e1: 3 mons at =
{osd151=3D10.194.0.68:6789/0,osd152=3D10.193.207.130:6789/0,osd153=3D10.19=
3.207.131:6789/0}, election epoch 40, quorum 0,1,2 =
osd151,osd152,osd153</div><div>&nbsp; &nbsp;osdmap e129885: 787 osds: =
758 up, 758 in</div><div>&nbsp; &nbsp; pgmap v1884502: 22203 pgs: 22125 =
active+clean, 1 active+clean+scrubbing, 1 active+clean+inconsistent, 76 =
active+clean+scrubbing+deep; 96319 GB data, 302 TB used, 762 TB / 1065 =
TB avail</div><div>&nbsp; &nbsp;mdsmap e1: 0/0/1 =
up</div></div><div><br></div><div>#<span style=3D"font-family: Calibri, =
sans-serif; font-size: 16px; ">When the latency peak happened, there was =
no scrubbing, recovering or backfilling at the =
moment.#</span></div><div><br></div><div>While the performance of the =
cluster (only with WRITE traffic) is stable until Dec 25th, our =
monitoring (for radosgw access log) shows a significant increase of =
average latency and 99% latency.</div><div><br></div><div>And then I =
chose one OSD and try to grep slow requests logs and find that most of =
the slow requests were waiting for subop, I take osd22 for =
example.</div><div><br></div><div>osd[561-571] are hosted by =
osd22.</div><div><div style=3D"font-family: Calibri, sans-serif; "><font =
style=3D"background-color: rgb(204, 204, 204); font-size: =
12px;">-bash-4.1$ for i in {561..571}; do grep "slow request" =
ceph-osd.$i.log | grep "2013-12-25 16"| grep osd_op | grep -oP "\d+,\d+" =
; done &gt; ~/slow_osd.txt</font></div><div style=3D"font-family: =
Calibri, sans-serif; "><font style=3D"background-color: rgb(204, 204, =
204); "><font face=3D"Calibri,sans-serif" style=3D"font-size: =
12px;">-bash-4.1$ cat ~/slow_osd.txt &nbsp;| sort | uniq -c | =
sort&nbsp;=96nr</font></font></div><div style=3D"font-family: Calibri, =
sans-serif; "><div><span style=3D"background-color: rgb(204, 204, 204); =
font-size: 12px;">&nbsp; &nbsp;3586 656,598</span></div><div><font =
style=3D"background-color: rgb(204, 204, 204); font-size: 12px;">&nbsp; =
&nbsp; 289 467,629</font></div><div><font style=3D"background-color: =
rgb(204, 204, 204); font-size: 12px;">&nbsp; &nbsp; 284 =
598,763</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; 279 584,598</font></div><div><font =
style=3D"background-color: rgb(204, 204, 204); font-size: 12px;">&nbsp; =
&nbsp; 203 172,598</font></div><div><font style=3D"background-color: =
rgb(204, 204, 204); font-size: 12px;">&nbsp; &nbsp; 182 =
598,6</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; 155 629,646</font></div><div><font =
style=3D"background-color: rgb(204, 204, 204); font-size: 12px;">&nbsp; =
&nbsp; &nbsp;83 631,598</font></div><div><font style=3D"background-color: =
rgb(204, 204, 204); font-size: 12px;">&nbsp; &nbsp; &nbsp;65 =
631,593</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp;21 =
616,629</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp;20 =
609,671</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp;20 =
609,390</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp;13 =
609,254</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp;12 =
702,629</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp;12 =
629,641</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp;11 =
665,613</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp;11 =
593,724</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp;11 =
361,591</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp;10 =
591,709</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 9 =
681,609</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 9 =
609,595</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 9 =
591,772</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 8 =
613,662</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 8 =
575,591</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 7 =
674,722</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 7 =
609,603</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 6 =
585,605</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 5 =
613,691</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 5 =
293,629</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 4 =
774,591</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 4 =
717,591</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 4 =
613,776</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 4 =
538,629</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 4 =
485,629</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 3 =
702,641</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 3 =
608,629</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 3 =
593,580</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;">&nbsp; &nbsp; &nbsp; 3 =
591,676</font></div><div><font style=3D"background-color: rgb(204, 204, =
204); font-size: 12px;"><br></font></div><div><font =
style=3D"background-color: rgb(204, 204, 204); font-size: 12px;"><div =
style=3D"font-size: 16px; ">It turns out most of the slow requests were =
waiting for osd 598, 629, I ran the procedure on another host osd22 and =
got the same pattern.</div><div style=3D"font-size: 16px; =
"><br></div><div style=3D"font-size: 16px; ">Then I turned to the host =
having osd598 and dump the perf counter to do comparision.</div><div =
style=3D"font-size: 16px; "><font size=3D"2"><br></font></div><div =
style=3D"font-size: 16px; "><div><font size=3D"2">-bash-4.1$ for i in =
{594..604}; do sudo ceph --admin-daemon /var/run/ceph/ceph-osd.$i.asok =
perf dump | ~/do_calc_op_latency.pl; =
done</font></div><div>op_latency,subop_latency,total_ops</div><div><font =
size=3D"2">0.192097526753471,0.0344513450167198,7549045</font></div><div><=
font =
size=3D"2">1.99137797628122,1.42198426157216,9184472</font></div><div><fon=
t =
size=3D"2">0.198062399664129,0.0387090378926376,6305973</font></div><div><=
font =
size=3D"2">0.621697271315762,0.396549768986993,9726679</font></div><div><f=
ont size=3D"2" color=3D"#ff0000">29.5222496247375,18.2888846379615, =
10860858</font></div><div><font =
size=3D"2">0.229250239525916,0.0557482067611005,8149691</font></div><div><=
font =
size=3D"2">0.208981698303654,0.0375553180438224,6623842</font></div><div><=
font =
size=3D"2">0.47474766302086,0.292583928601509,9838777</font></div><div><fo=
nt =
size=3D"2">0.339477790083925,0.101288409388438,9340212</font></div><div><f=
ont =
size=3D"2">0.186448840141895,0.0327296517417626,7081410</font></div><div><=
font =
size=3D"2">0.807598201207144,0.0139762289702332,6093531</font></div><div><=
font size=3D"2" style=3D"background-color: transparent; ">(osd 598 is op =
hotspot as well)</font></div><div><font =
size=3D"2"><br></font></div><div>This double confirmed that osd 598 was =
having some performance issues (it has around&nbsp;<b>30 seconds average =
op latency</b>!).</div><div>sar shows slightly higher disk I/O for osd =
598 (/dev/sdf) but the latency difference is not as significant as we =
saw from osd perf.</div><div>reads &nbsp; kbread writes &nbsp;kbwrite =
%busy &nbsp;avgqu &nbsp;await &nbsp;svctm</div><div>37.3 &nbsp; =
&nbsp;459.9 &nbsp; &nbsp;89.8 &nbsp; &nbsp; 4106.9 &nbsp; 61.8 &nbsp; =
&nbsp; 1.6 &nbsp; &nbsp; &nbsp; 12.2 &nbsp; &nbsp;4.9</div><div>42.3 =
&nbsp; &nbsp;545.8 &nbsp; &nbsp;91.8 &nbsp; &nbsp; 4296.3 &nbsp; 69.7 =
&nbsp; &nbsp; 2.4 &nbsp; &nbsp; &nbsp; 17.6 &nbsp; =
&nbsp;5.2&nbsp;</div><div>42.0 &nbsp; &nbsp;483.8 &nbsp; &nbsp;93.1 =
&nbsp; &nbsp; 4263.6 &nbsp; 68.8 &nbsp; &nbsp; 1.8 &nbsp; &nbsp; &nbsp; =
13.3 &nbsp; &nbsp;5.1</div><div>39.7 &nbsp; &nbsp;425.5 &nbsp; =
&nbsp;89.4 &nbsp; &nbsp; 4327.0 &nbsp; 68.5 &nbsp; &nbsp; 1.8 &nbsp; =
&nbsp; &nbsp; 14.0 &nbsp; &nbsp;5.3</div><div><br></div><div>Another =
disk at the same time for comparison (/dev/sdb).</div><div>reads &nbsp; =
kbread writes &nbsp;kbwrite %busy &nbsp;avgqu &nbsp;await =
&nbsp;svctm</div><div>34.2 &nbsp; &nbsp;502.6 &nbsp; &nbsp;80.1 &nbsp; =
&nbsp;3524.3 &nbsp; &nbsp;53.4 &nbsp; &nbsp; 1.3 &nbsp; &nbsp; 11.8 =
&nbsp; &nbsp; &nbsp;4.7</div></div><div style=3D"font-size: 16px; ">35.3 =
&nbsp; &nbsp;560.9 &nbsp; &nbsp;83.7 &nbsp; &nbsp;3742.0 &nbsp; =
&nbsp;56.0 &nbsp; &nbsp; 1.2 &nbsp; &nbsp; 9.8 &nbsp; &nbsp; &nbsp; =
4.7&nbsp;</div><div style=3D"font-size: 16px; ">30.4 &nbsp; &nbsp;371.5 =
&nbsp; 78.8 &nbsp; &nbsp; 3631.4 &nbsp; &nbsp;52.2 &nbsp; &nbsp; 1.7 =
&nbsp; &nbsp; 15.8 &nbsp; &nbsp; 4.8</div><div style=3D"font-size: 16px; =
">33.0 &nbsp; &nbsp;389.4 &nbsp; 78.8 &nbsp; &nbsp; &nbsp;3597.6 &nbsp; =
54.2 &nbsp; &nbsp; 1.4 &nbsp; &nbsp; &nbsp;12.1 &nbsp; =
&nbsp;4.8</div><div style=3D"font-size: 16px; "><br></div><div =
style=3D"font-size: 16px; ">Any idea why a couple of OSDs are so slow =
that impact the performance of the entire cluster?</div><div =
style=3D"font-size: 16px; "><br></div><div style=3D"font-size: 16px; =
">Thanks,</div><div style=3D"font-size: 16px; =
">Guang</div></font></div></div></div></body></html>=

--Apple-Mail=_6FCF430B-0A61-48D7-95D1-DFB16EB47DF8--

--===============1124912741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1124912741==--
