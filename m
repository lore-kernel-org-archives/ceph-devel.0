From: Isaac Otsiabah <zmoo76b@yahoo.com>
Subject: Re: osd down (for 2 about 2 minutes) error after adding a new host to my cluster
Date: Mon, 28 Jan 2013 12:17:41 -0800 (PST)
Message-ID: <1359404261.7789.YahooMailNeo@web121901.mail.ne1.yahoo.com>
References: <1359048283.79398.YahooMailNeo@web121906.mail.ne1.yahoo.com> <4428CF82A82E485B81CB865DFBE92465@inktank.com> <1359136273.17901.YahooMailNeo@web121903.mail.ne1.yahoo.com>
Reply-To: Isaac Otsiabah <zmoo76b@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2019092845-1273885361-1359404261=:7789"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nm10-vm0.bullet.mail.ne1.yahoo.com ([98.138.91.72]:42077 "EHLO
	nm10-vm0.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751166Ab3A1URm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Jan 2013 15:17:42 -0500
In-Reply-To: <1359136273.17901.YahooMailNeo@web121903.mail.ne1.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

--2019092845-1273885361-1359404261=:7789
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

=0A=0AGregory, i recreated the osd down problem again this morning on two n=
odes (g13ct, g14ct). First, i created a 1-node cluster on g13ct (with osd.0=
, 1 ,2) and then added host g14ct (osd3. 4, 5). osd.1 went down for about 1=
 minute and half after adding osd 3, 4, 5 were adde4d. i have included the =
routing table of each node at the time osd.1 went down. ceph.conf and ceph-=
osd.1.log files are attached. The crush map was default. Also, it could be =
a timing issue because it does not always fail when=A0 using default crush =
map, it takes several trials before you see it. Thank you.=0A=0A=0A[root@g1=
3ct ~]# netstat -r=0AKernel IP routing table=0ADestination=A0=A0=A0=A0 Gate=
way=A0=A0=A0=A0=A0=A0=A0=A0 Genmask=A0=A0=A0=A0=A0=A0=A0=A0 Flags=A0=A0 MSS=
 Window=A0 irtt Iface=0Adefault=A0=A0=A0=A0=A0=A0=A0=A0 133.164.98.250 0.0.=
0.0=A0=A0=A0=A0=A0=A0=A0=A0 UG=A0=A0=A0=A0=A0=A0=A0 0 0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0 eth2=0A133.164.98.0=A0=A0=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 255.255.255.0=A0=A0 U=A0=A0=A0=A0=A0=A0=A0=A0 0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0 eth2=0Alink-local=A0=A0=A0=A0=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 255.255.0.0=A0=A0=A0=A0 U=A0=A0=A0=A0=A0=A0=A0=A0 0 0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0 eth3=0Alink-local=A0=A0=A0=A0=A0 *=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 255.255.0.0=A0=A0=A0=A0 U=A0=A0=A0=A0=A0=A0=
=A0=A0 0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 eth0=0Alink-local=A0=A0=A0=A0=A0 *=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 255.255.0.0=A0=A0=A0=A0 U=A0=A0=
=A0=A0=A0=A0=A0=A0 0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 eth2=0A192.0.0.0=A0=A0=
=A0=A0=A0=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 255.0.0.0=A0=A0=A0=
=A0=A0=A0 U=A0=A0=A0=A0=A0=A0=A0=A0 0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 eth3=
=0A192.0.0.0=A0=A0=A0=A0=A0=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
255.0.0.0=A0=A0=A0=A0=A0=A0 U=A0=A0=A0=A0=A0=A0=A0=A0 0 0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0 eth0=0A192.168.0.0=A0=A0=A0=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 255.255.255.0=A0=A0 U=A0=A0=A0=A0=A0=A0=A0=A0 0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0 eth3=0A192.168.1.0=A0=A0=A0=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 255.255.255.0=A0=A0 U=A0=A0=A0=A0=A0=A0=A0=A0 0 0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0 eth0=0A[root@g13ct ~]# ceph osd tree=0A=0A# id=A0=
=A0=A0 weight=A0 type name=A0=A0=A0=A0=A0=A0 up/down reweight=0A-1=A0=A0=A0=
=A0=A0 6=A0=A0=A0=A0=A0=A0 root default=0A-3=A0=A0=A0=A0=A0 6=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rack unknownrack=0A-2=A0=A0=A0=A0=A0 3=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 host g13ct=0A0=
=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.0=A0=A0 up=A0=A0=A0=A0=A0 1=0A1=A0=
=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.1=A0=A0 down=A0=A0=A0 1=0A2=A0=A0=A0=
=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.2=A0=A0 up=A0=A0=A0=A0=A0 1=0A-4=A0=A0=A0=
=A0=A0 3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
host g14ct=0A3=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.3=A0=A0 up=A0=A0=A0=
=A0=A0 1=0A4=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.4=A0=A0 up=A0=A0=A0=A0=
=A0 1=0A5=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.5=A0=A0 up=A0=A0=A0=A0=A0=
 1=0A=0A=0A=0A[root@g14ct ~]# ceph osd tree=0A=0A# id=A0=A0=A0 weight=A0 ty=
pe name=A0=A0=A0=A0=A0=A0 up/down reweight=0A-1=A0=A0=A0=A0=A0 6=A0=A0=A0=
=A0=A0=A0 root default=0A-3=A0=A0=A0=A0=A0 6=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 rack unknownrack=0A-2=A0=A0=A0=A0=A0 3=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 host g13ct=0A0=A0=A0=A0=A0=A0=A0=
 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 osd.0=A0=A0 up=A0=A0=A0=A0=A0 1=0A1=A0=A0=A0=A0=A0=A0 1=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 osd.1=A0=A0 down=A0=A0=A0 1=0A2=A0=A0=A0=A0=A0=A0 1=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 osd.2=A0=A0 up=A0=A0=A0=A0=A0 1=0A-4=A0=A0=A0=A0=A0 3=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 host g14ct=0A3=A0=A0=
=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.3=A0=A0 up=A0=A0=A0=A0=A0 1=0A4=A0=A0=A0=
=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.4=A0=A0 up=A0=A0=A0=A0=A0 1=0A5=A0=A0=A0=A0=
=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 osd.5=A0=A0 up=A0=A0=A0=A0=A0 1=0A=0A[root@g14ct ~=
]# netstat -r=0AKernel IP routing table=0ADestination=A0=A0=A0=A0 Gateway=
=A0=A0=A0=A0=A0=A0=A0=A0 Genmask=A0=A0=A0=A0=A0=A0=A0=A0 Flags=A0=A0 MSS Wi=
ndow=A0 irtt Iface=0Adefault=A0=A0=A0=A0=A0=A0=A0=A0 133.164.98.250 0.0.0.0=
=A0=A0=A0=A0=A0=A0=A0=A0 UG=A0=A0=A0=A0=A0=A0=A0 0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0 eth0=0A133.164.98.0=A0=A0=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 255.255.255.0=A0=A0 U=A0=A0=A0=A0=A0=A0=A0=A0 0 0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0 eth0=0Alink-local=A0=A0=A0=A0=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 255.255.0.0=A0=A0=A0=A0 U=A0=A0=A0=A0=A0=A0=A0=A0 0 0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0 eth3=0Alink-local=A0=A0=A0=A0=A0 *=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 255.255.0.0=A0=A0=A0=A0 U=A0=A0=A0=A0=A0=A0=A0=
=A0 0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 eth5=0Alink-local=A0=A0=A0=A0=A0 *=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 255.255.0.0=A0=A0=A0=A0 U=A0=A0=A0=
=A0=A0=A0=A0=A0 0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 eth0=0A192.0.0.0=A0=A0=A0=
=A0=A0=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 255.0.0.0=A0=A0=A0=A0=
=A0=A0 U=A0=A0=A0=A0=A0=A0=A0=A0 0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 eth3=0A19=
2.0.0.0=A0=A0=A0=A0=A0=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 255.0=
.0.0=A0=A0=A0=A0=A0=A0 U=A0=A0=A0=A0=A0=A0=A0=A0 0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0 eth5=0A192.168.0.0=A0=A0=A0=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 255.255.255.0=A0=A0 U=A0=A0=A0=A0=A0=A0=A0=A0 0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0 eth3=0A192.168.1.0=A0=A0=A0=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 255.255.255.0=A0=A0 U=A0=A0=A0=A0=A0=A0=A0=A0 0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0 eth5=0A[root@g14ct ~]# ceph osd tree=0A=0A# id=A0=A0=
=A0 weight=A0 type name=A0=A0=A0=A0=A0=A0 up/down reweight=0A-1=A0=A0=A0=A0=
=A0 6=A0=A0=A0=A0=A0=A0 root default=0A-3=A0=A0=A0=A0=A0 6=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 rack unknownrack=0A-2=A0=A0=A0=A0=A0 3=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 host g13ct=0A0=A0=
=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.0=A0=A0 up=A0=A0=A0=A0=A0 1=0A1=A0=A0=
=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.1=A0=A0 down=A0=A0=A0 1=0A2=A0=A0=A0=A0=
=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 osd.2=A0=A0 up=A0=A0=A0=A0=A0 1=0A-4=A0=A0=A0=A0=
=A0 3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hos=
t g14ct=0A3=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.3=A0=A0 up=A0=A0=A0=A0=
=A0 1=0A4=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.4=A0=A0 up=A0=A0=A0=A0=A0=
 1=0A5=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd.5=A0=A0 up=A0=A0=A0=A0=A0 1=
=0A=0A=0A=0A=0A=0AIsaac=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A----- Original Mess=
age -----=0AFrom: Isaac Otsiabah <zmoo76b@yahoo.com>=0ATo: Gregory Farnum <=
greg@inktank.com>=0ACc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kerne=
l.org>=0ASent: Friday, January 25, 2013 9:51 AM=0ASubject: Re: osd down (fo=
r 2 about 2 minutes) error after adding a new host to my cluster=0A=0A=0A=
=0AGregory, the network physical layout is simple, the two networks are =0A=
separate. the 192.168.0 and the 192.168.1 are not subnets within a =0Anetwo=
rk.=0A=0AIsaac=A0 =0A=0A=0A=0A=0A----- Original Message -----=0AFrom: Grego=
ry Farnum <greg@inktank.com>=0ATo: Isaac Otsiabah <zmoo76b@yahoo.com>=0ACc:=
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>=0ASent: Thursday=
, January 24, 2013 1:28 PM=0ASubject: Re: osd down (for 2 about 2 minutes) =
error after adding a new host to my cluster=0A=0AWhat's the physical layout=
 of your networking? This additional log may prove helpful as well, but I r=
eally need a bit more context in evaluating the messages I see from the fir=
st one. :) =0A-Greg=0A=0A=0AOn Thursday, January 24, 2013 at 9:24 AM, Isaac=
 Otsiabah wrote:=0A=0A> =0A> =0A> Gregory, i tried send the the attached de=
bug output several times and =0A> the mail server rejected them all probabl=
y becauseof the file size so i cut the log file size down and it is attache=
d. You will see the =0A> reconnection failures by the error message line be=
low. The ceph version =0A> is 0.56=0A> =0A> =0A> it appears to be a timing =
issue because with the flag (debug ms=3D1) turned on, the system ran slower=
 and became harder to fail.=0A> I=0A> ran it several times and finally got =
it to fail on (osd.0) using =0A> default crush map. The attached tar file c=
ontains log files for all =0A> components on g8ct plus the ceph.conf. By th=
e way, the log file contain only the last 1384 lines where the error occurs=
.=0A> =0A> =0A> I started with a 1-node cluster on host g8ct (osd.0, osd.1,=
 osd.2) and then added host g13ct (osd.3, osd.4, osd.5)=0A> =0A> =0A> id we=
ight type name up/down reweight=0A> -1 6 root default=0A> -3 6 rack unknown=
rack=0A> -2 3 host g8ct=0A> 0 1 osd.0 down 1=0A> 1 1 osd.1 up 1=0A> 2 1 osd=
.2 up 1=0A> -4 3 host g13ct=0A> 3 1 osd.3 up 1=0A> 4 1 osd.4 up 1=0A> 5 1 o=
sd.5 up 1=0A> =0A> =0A> =0A> The error messages are in ceph.log and ceph-os=
d.0.log:=0A> =0A> ceph.log:2013-01-08=0A> 05:41:38.080470 osd.0 192.168.0.1=
24:6801/25571 3 : [ERR] map e15 had =0A> wrong cluster addr (192.168.0.124:=
6802/25571 !=3D my =0A> 192.168.1.124:6802/25571)=0A> ceph-osd.0.log:2013-0=
1-08 05:41:38.080458 7f06757fa710 0 log [ERR] : map e15 had wrong cluster a=
ddr =0A> (192.168.0.124:6802/25571 !=3D my 192.168.1.124:6802/25571)=0A> =
=0A> =0A> =0A> [root@g8ct ceph]# ceph -v=0A> ceph version 0.56 (1a32f0a0b42=
f169a7b55ed48ec3208f6d4edc1e8)=0A> =0A> =0A> Isaac=0A> =0A> =0A> ----- Orig=
inal Message -----=0A> From: Gregory Farnum <greg@inktank.com (mailto:greg@=
inktank.com)>=0A> To: Isaac Otsiabah <zmoo76b@yahoo.com (mailto:zmoo76b@yah=
oo.com)>=0A> Cc: "ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel=
.org)" <ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.org)>=0A>=
 Sent: Monday, January 7, 2013 1:27 PM=0A> Subject: Re: osd down (for 2 abo=
ut 2 minutes) error after adding a new host to my cluster=0A> =0A> On Monda=
y, January 7, 2013 at 1:00 PM, Isaac Otsiabah wrote:=0A> =0A> =0A> When i a=
dd a new host (with osd's) to my existing cluster, 1 or 2 =0A> previous osd=
(s) goes down for about 2 minutes and then they come back =0A> up. =0A> > =
=0A> > =0A> > [root@h1ct ~]# ceph osd tree=0A> > =0A> > # id weight type na=
me up/down reweight=0A> > -1 =0A> > 3 root default=0A> > -3 3 rack unknownr=
ack=0A> > -2 3 host h1=0A> > 0 1 osd.0 up 1=0A> > 1 1 osd.1 up 1=0A> > 2 =
=0A> > 1 osd.2 up 1=0A> =0A> =0A> For example, after adding host h2 (with 3=
 new osd) to the above cluster=0A> and running the "ceph osd tree" command,=
 i see this: =0A> > =0A> > =0A> > [root@h1 ~]# ceph osd tree=0A> > =0A> > #=
 id weight type name up/down reweight=0A> > -1 6 root default=0A> > -3 =0A>=
 > 6 rack unknownrack=0A> > -2 3 host h1=0A> > 0 1 osd.0 up 1=0A> > 1 1 osd=
.1 down 1=0A> > 2 =0A> > 1 osd.2 up 1=0A> > -4 3 host h2=0A> > 3 1 osd.3 up=
 1=0A> > 4 1 osd.4 up =0A> > 1=0A> > 5 1 osd.5 up 1=0A> =0A> =0A> The down =
osd always come back up after 2 minutes or less andi see the =0A> following=
 error message in the respective osd log file: =0A> > 2013-01-07 04:40:17.6=
13028 7fec7f092760 1 journal _open =0A> > /ceph_journal/journals/journal_2 =
fd 26: 1073741824 bytes, block size =0A> > 4096 bytes, directio =3D 1, aio =
=3D 0=0A> > 2013-01-07 04:40:17.613122 =0A> > 7fec7f092760 1 journal _open =
/ceph_journal/journals/journal_2 fd 26: =0A> > 1073741824 bytes, block size=
 4096 bytes, directio =3D 1, aio =3D 0=0A> > 2013-01-07=0A> > 04:42:10.0065=
33 7fec746f7710 0 -- 192.168.0.124:6808/19449 >> =0A> > 192.168.1.123:6800/=
18287 pipe(0x7fec20000e10 sd=3D31 :6808 pgs=3D0 cs=3D0 =0A> > l=3D0).accept=
 connect_seq 0 vs existing 0 state connecting=0A> > 2013-01-07 =0A> > 04:45=
:29.834341 7fec743f4710 0 -- 192.168.1.124:6808/19449 >> =0A> > 192.168.1.1=
22:6800/20072 pipe(0x7fec5402f320 sd=3D28 :45438 pgs=3D7 cs=3D1 =0A> > l=3D=
0).fault, initiating reconnect=0A> > 2013-01-07 04:45:29.835748 =0A> > 7fec=
743f4710 0 -- 192.168.1.124:6808/19449 >> =0A> > 192.168.1.122:6800/20072 p=
ipe(0x7fec5402f320 sd=3D28 :45439 pgs=3D15 cs=3D3 =0A> > l=3D0).fault, init=
iating reconnect=0A> > 2013-01-07 04:45:30.835219 7fec743f4710 0 -- =0A> > =
192.168.1.124:6808/19449 >> 192.168.1.122:6800/20072 =0A> > pipe(0x7fec5402=
f320 sd=3D28 :45894 pgs=3D482 cs=3D903 l=3D0).fault, initiating =0A> > reco=
nnect=0A> > 2013-01-07 04:45:30.837318 7fec743f4710 0 -- =0A> > 192.168.1.1=
24:6808/19449 >> 192.168.1.122:6800/20072 =0A> > pipe(0x7fec5402f320 sd=3D2=
8 :45895 pgs=3D483 cs=3D905 l=3D0).fault, initiating =0A> > reconnect=0A> >=
 2013-01-07 04:45:30.851984 7fec637fe710 0 log [ERR] : map =0A> > e27 had w=
rong cluster addr (192.168.0.124:6808/19449 !=3D my =0A> > 192.168.1.124:68=
08/19449)=0A> > =0A> > Also, this only happens only when the cluster ip add=
ress and the public ip address are different for example=0A> > ....=0A> > .=
...=0A> > ....=0A> > [osd.0]=0A> > host =3D g8ct=0A> > public address =3D 1=
92.168.0.124=0A> > cluster address =3D 192.168.1.124=0A> > btrfs devs =3D /=
dev/sdb=0A> > =0A> > ....=0A> > ....=0A> > =0A> > but does not happen when =
they are the same. Any idea what may be the issue?=0A> This isn't familiar =
to me at first glance. What version of Ceph are you using?=0A> =0A> If=0A> =
this is easy to reproduce, can you pastebin your ceph.conf and then add=0A>=
 "debug ms =3D 1" to your global config and gather up the logs from each =
=0A> daemon?=0A> -Greg=0A> =0A> --=0A> To unsubscribe from this list: send =
the line "unsubscribe ceph-devel" in=0A> the body of a message to majordomo=
@vger.kernel.org (mailto:majordomo@vger.kernel.org)=0A> More majordomo info=
 at http://vger.kernel.org/majordomo=0A> =0A> =0A> Attachments: =0A> - ceph=
-osd.0.log.tar.gz=0A> =0A=0A=0A=0A--=0ATo unsubscribe from this list: send =
the line "unsubscribe ceph-devel" in=0Athe body of a message to majordomo@v=
ger.kernel.org=0AMore majordomo info at=A0 http://vger.kernel.org/majordomo=
-info.html
--2019092845-1273885361-1359404261=:7789
Content-Type: application/x-gzip; name="osd.1.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="osd.1.tar.gz"

H4sICNLVBlEAA29zZC4xLnRhcgDknW1vHMdyhfU5v2K+2QZMsrteuqqF2IDg
6AYGfHUN20hgBIGwIpcyr2kuwaXutfLr0zNVlEWJxIolb9lBCFsvlDR9dma6
TvXMmWcOjx7t/auML2Gef67Cdfl9JVp+9q9HFWqpzNBYHpU6/jo9mnj/0h49
erW9Xl1N06PN9fZs9eJse//fW1/d+4f/d78Oj47Xlz8dbLYnh/XwfPNyH2PM
B7jZ8X7/+CMKjO/dHH9ubRx/RIRHU9mHmHe//p8ffxg7+6DUA9CplsdMj1EO
W1cRmOQU8aQLNmllmup0ena+3l5vrtafHp2srldH45x5Xj+bfvn5dDudXUxv
ffNf7tlq1/agrb5cX6yvVtfrk+l0e3Yy1fWqI/P6QE+0HVCXetD7Sg5OqPdx
Hp2evFjBnUP3pqDlQ4c+X/9jfX7yYhr/rX89215vj46v1rOKu7etQ1J9b9t/
37y6ulidT883l+uxb+ZJ9ty/d+Q/b29+8XxIOZm3OP4XFKoKNL14fb3efj69
ON8c/zxtz/5nPVHp7ebbJ2dX6+Prs830xVQ/n1bLL8od+vSwYNP2rr5y/26/
Ee6f+c0H2ez+FPeO/8DDfrK5WO8+o/SwVtH64R9t8+rievrL10//+uTb6Wxz
fH0+nW2n7avLy83V/EFXF+P/y8v16mo7XW+mf26ufr53VOCPG/XkbLt6cT4G
/cfZavrkzT8dG1n/srr8ZDreXJyevZw2l+MQX9yjQmt595TeoeJkfT1OmjHq
i+ur0+29m634sM0uW5u++uZvz54+/+7Js39/esfevXMwgFbpgcfPBvv+2ZNv
n3/13dMnPzz9oGGA3i1nHz7Mvz39/ofv/vbjB42DNTbOD0++++H59z8+++r2
Kfnp9dXqYql8/NndQ0opKpEh//PJ13eMeN8g3EODvHWYnv8H7B4JGUeRe9hI
29fb49X5+aff//j98+3ri+PTUR1PTz6bTl+dn7/ePR4/9Gw/HT+eTNuL1eV2
+tf65Z3b5dHKyMM+x+NpfTFKwtnFy+nbJ989+eabp9+8Kb2/bE7Wj22Xfv7u
Pn0zp+fy9VYlsQMwy/xk+ffzzl9GuGdXDMlS9PewsbYXG+Mymgf6E+sbZfPd
/Xdwr80db16dn0wXm3E6nY3jBngMp8cn6+WPxym7vlr0HJWjo7GN4YTjL61/
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
cJcaHElaHMR8fT7SdCa6sY2WPrrbn6YzgjnSkq3OUrx28pYaYysv+phOaQhX
yynDxnWXXjCFv+VEcvuTLMn6Gu535y01OJK003p50O7rkdwRvO3TrhckyquR
yOkFcytUOg2nUOFITs+cW3kxitzZdz7S3pkL5jZaBgzwNO2dhRRH4hYfXPi6
kdyzQ5D92peHj70a6cY9O2wS6QUN83okJ9/NrawflcBr8Rsnt3CkuUVqXh+/
cebMed3kuxsvDzl+NdLBGXccqW37tsUbLQe3FzSeM8csxct33lJjbnPmmOBG
OjoLziWXRZHXLOT1gqMzZ64tB89tZ8ApWJ3qcG25ZcJ0c/DJmVXWVo1PBGfB
yZGcFl/bhcPZ0ZnpOFF7geTqzOzLKXrwypnFaatUVilOZsErpwvQVl5wYQie
InA6OG1XVFYhZ4HAH+e0Em0T5oLmXF1Fdy+CtglzIToLBI7ktpN0gdWqU4zj
VXWKAtqWGqt5aZMjOd2Stt602oLzhQpHcoon2iYn2Yw7P+i4XzqDjnSHbA4/
0vl0AGVbIKxFThnGkc63k0SSnrlWPT+Jc6Tz05xEGlsk51ofXo3z0xxHkutq
BOgsEznS+XEnkbhnEpbltbiz1OBItUikTl4fd5YaEgkk0nSuP+LVPD/RSSSe
xKm+3P//eqTzI5gjNdHUvGIcvaWGRJLvrnVn+YPeXoRsKUuLj1bOJ2CO5PYn
WWrQ4JLOi3R+zpRIcnaj+5HcESw7UjTIudCDV+T2Alm00BxOaciR3J4p8xPN
tby5gJy5ALa5gHi4eHPB/vxCaqvpJNJy58y9c3ZSYlzVsgHVnEju2XGBIZHc
cefsRcgflEjTKaE50vncIn+qRFrO5VWO5MyZIEVm5WrVueyAVwdn3G177xxp
OvvcHMntBSDfHSy3VnGWGvKHOBIWZ/nDxeH5BSf/QfnuuGL1+rizFyGRmkRa
6NWZp/PVoUTqEonIa6eTM6uA5DvZAnR2EznS+RbHsfUCQQdbOx3qbXvdzATl
F5qZWlldSHBiZupiZkJ7KsswT/InTqbdX+6e3u0+3D+9EyvT0/3u8fTh+E+7
b++f//m0/3C8+fFvnAJ3GpjzeYvngC+N8UtPAd9WHu7181NoeOxHPQXccY55
vilDWbG/yhlwF2ul9mcbzAFu8ZedwYsfa/FrVYgeL2dwcziUekT4q6NMbgOX
EzA/2a9xAtIfcZFdBuO1RvgraPwVyLMgPrPEYdnPvZ5A468Auhlq5692AlyE
cEJc3cqZQ7vtwW8A+bWNh/b5N3C4PWwnwJ/4yTcA0RP44nL8FsfV28Pp+3dX
h/sPt7/ZZ3BtUkZr8jdnX9j+DfpvORDn+AJQblDriG18IbdjtvrFrvxmij45
PnIHe9jtvrh/erzb39w9vv6+08OrL/7/Pb7+9v39zf79N2++/P7uuLu9e3/a
fbV7+8P+4e3Dxw9b33j7hw/7705X/PKbL/98+vFBxiW/5fR00JftZ1c3dx/e
fLn/yIP52UH7cPrPj3cPpyO/Xd75X/YyN+QPd4fTay8f3t+dPjz9/NU3X393
/4F18n93x/3TXkTI32/5B3/6A6vb3nBV+C3v7h+f+OVvoR6e9Bc2M+9XP527
5iL5rePjN+dPbWsBfefP47/5+v7xyD/k/36ui3+w6dptL/3H/ceHD/v38qrE
/pP9+639/fj8P9uvfPYbj3f/LV+KPG73zd9/+fzT4909//CWf/P0vxPPIf9G
43z/8eb93WFrn9Pj40+b6M2Xn7qhP38D6Btunh5uH7nm+uFxO/HTD28fH4/F
Pg9SPu94tI/DnI97bs36zZudHi8f2vhD7WeffPRPPhef3/KZ1fzzj355zyvt
u1MJ7XeSwE1uCvrvpeDECn7v2fNyXI7LcTkux+W4HJfjclyOy3E5LsfluByX
43JcjstxOf7vHv8DA59SwwDgAQA=

--2019092845-1273885361-1359404261=:7789--
