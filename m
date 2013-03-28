From: Sebastien Han <sebastien.han-TBbEfUtgOqVWk0Htik3J/w@public.gmane.org>
Subject: Puppet modules for Ceph finally landed!
Date: Thu, 28 Mar 2013 10:34:47 +0100
Message-ID: <2C8FAE48-A968-4999-A7B7-20A8D47805CE@enovance.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: multipart/mixed; boundary="===============0388400964=="
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
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


--===============0388400964==
Content-Type: multipart/alternative; boundary="Apple-Mail=_66978017-B996-40E7-8969-E11BC35A7BA4"


--Apple-Mail=_66978017-B996-40E7-8969-E11BC35A7BA4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hello everybody,

Quite recently Fran=E7ois Charlier and I worked together on the Puppet =
modules for Ceph on behalf of our employer eNovance. In fact, Fran=E7ois =
started to work on them last summer, back then he achieved the Monitor =
manifests. So basically, we worked on the OSD manifest. Modules are in =
pretty good shape thus we thought it was important to communicate to the =
community. That's enough talk, let's dive into these modules and explain =
what do they do. See below what's available:
=20
* Testing environment is Vagrant ready.
* Bobtail Debian latest stable version will be installed
* The module only supports CephX, at least for now
* Generic deployment for 3 monitors based on a template file =
examples/common.sh which respectively includes mon.sh, osd.sh, mds.sh.
* Generic deployment for N OSDs. OSD disks need to be set from the =
examples/site.pp file (line 71). Puppet will format specified disks in =
XFS (only filesystem implemented) using these options: `-f -d =
agcount=3D<cpu-core-number> -l size=3D1024m -n size=3D64k` and finally =
mounted with: `rw,noatime,inode64`. Then it will mount all of them and =
append the appropriate lines in the fstab file of each storage node. =
Finally the OSDs will be added into Ceph.
=20
All the necessary materials (sources and how-to) are publicly available =
(and for free) under AGPL license on Github at =
https://github.com/enovance/puppet-ceph . Those manifests do the job =
quite nicely, although we still need to work on MDS (90% done, just need =
a validation),  RGW (0% done) and a more flexible implementation =
(authentication and filesystem support). Obviously comments, =
constructive critics and feedback are more then welcome. Thus don't =
hesitate to drop an email to either Fran=E7ois (f.charlier-TBbEfUtgOqVWk0Htik3J/w@public.gmane.org) =
or I (sebastien-TBbEfUtgOqVWk0Htik3J/w@public.gmane.org) if you have further questions.

Cheers!

=96=96=96=96
S=E9bastien Han
Cloud Engineer

"Always give 100%. Unless you're giving blood."









PHONE : +33 (0)1 49 70 99 72 =96 MOBILE : +33 (0)6 52 84 44 70
EMAIL : sebastien.han-TBbEfUtgOqVWk0Htik3J/w@public.gmane.org =96 SKYPE : han.sbastien
ADDRESS : 10, rue de la Victoire =96 75009 Paris
WEB : www.enovance.com =96 TWITTER : @enovance


--Apple-Mail=_66978017-B996-40E7-8969-E11BC35A7BA4
Content-Type: multipart/related;
	type="text/html";
	boundary="Apple-Mail=_9C71749E-CEEB-4BDE-B8E0-5106C23A460D"


--Apple-Mail=_9C71749E-CEEB-4BDE-B8E0-5106C23A460D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
"><div>Hello everybody,</div><div><br></div>Quite recently&nbsp;Fran=E7ois=
 Charlier&nbsp;and&nbsp;I&nbsp;worked together on the Puppet modules for =
Ceph on behalf of our employer&nbsp;eNovance. In fact, Fran=E7ois =
started to work on them last summer, back then he achieved the Monitor =
manifests. So basically, we worked on the OSD&nbsp;manifest. Modules are =
in pretty good shape thus we thought it was important to communicate to =
the community. That's enough talk, let's dive into these modules and =
explain what do they do. See below what's available:<br>&nbsp;<br><div>* =
Testing environment is&nbsp;Vagrant&nbsp;ready.<br></div><div>* Bobtail =
Debian latest stable version will be installed<br></div><div>* The =
module only supports CephX, at least for now<br></div><div>* Generic =
deployment for 3 monitors based on a template file examples/common.sh =
which respectively includes mon.sh, osd.sh, mds.sh.<br></div><div>* =
Generic deployment for N OSDs. OSD disks need to be set from the =
examples/site.pp file (line 71). Puppet will format specified disks in =
XFS (only filesystem implemented) using these options: `-f -d =
agcount=3D&lt;cpu-core-number&gt; -l size=3D1024m -n size=3D64k`&nbsp;and =
finally mounted with: `rw,noatime,inode64`. Then it will mount all of =
them and append the appropriate lines in the fstab file of each storage =
node. Finally the OSDs will be added into Ceph.<br></div>&nbsp;<br>All =
the necessary materials (sources and how-to) are publicly available (and =
for free) under AGPL license on&nbsp;Github at&nbsp;<a =
href=3D"https://github.com/enovance/puppet-ceph">https://github.com/enovan=
ce/puppet-ceph</a>&nbsp;. Those manifests do the job quite nicely, =
although we still need to work on MDS (90% done, just need a =
validation), &nbsp;RGW (0% done) and a more&nbsp;flexible implementation =
(authentication and filesystem support). Obviously comments, =
constructive critics and feedback are more then welcome. Thus don't =
hesitate to drop an email to either Fran=E7ois (<a =
href=3D"mailto:f.charlier-TBbEfUtgOqVWk0Htik3J/w@public.gmane.org">f.charlier-TBbEfUtgOqVWk0Htik3J/w@public.gmane.org</a>) or =
I (<a href=3D"mailto:sebastien-TBbEfUtgOqVWk0Htik3J/w@public.gmane.org">sebastien-TBbEfUtgOqVWk0Htik3J/w@public.gmane.org</a>) =
if&nbsp;you have further =
questions.<div><br></div><div>Cheers!</div><div><br><div =
apple-content-edited=3D"true">=96=96=96=96<br>S=E9bastien Han<br>Cloud =
Engineer<br><br>"Always give 100%. Unless you're giving =
blood."<br><br><br><br><span><img height=3D"38" width=3D"200" =
id=3D"4ae0cf81-4a7f-4d71-8004-0351400aa5b9" apple-width=3D"yes" =
apple-height=3D"yes" =
src=3D"cid:30579C49-4F06-4D82-87C1-C0E41DE85D60-TBbEfUtgOqVWk0Htik3J/w@public.gmane.org"></span><br><=
br><br><br><br><br>PHONE :&nbsp;+33 (0)1 49 70 99 72&nbsp;=96&nbsp;MOBILE =
:&nbsp;+33 (0)6 52 84 44 70<br>EMAIL :&nbsp;<a =
href=3D"mailto:sebastien.han-TBbEfUtgOqVWk0Htik3J/w@public.gmane.org">sebastien.han-TBbEfUtgOqVWk0Htik3J/w@public.gmane.org</a>&=
nbsp;=96&nbsp;SKYPE :&nbsp;han.sbastien<br>ADDRESS :&nbsp;10, rue de la =
Victoire =96 75009 Paris<br>WEB =
:&nbsp;www.enovance.com&nbsp;=96&nbsp;TWITTER =
:&nbsp;@enovance</div><br></div></body></html>=

--Apple-Mail=_9C71749E-CEEB-4BDE-B8E0-5106C23A460D
Content-Transfer-Encoding: base64
Content-Disposition: inline;
	filename=image.png
Content-Type: image/png;
	name="image.png"
Content-Id: <30579C49-4F06-4D82-87C1-C0E41DE85D60-TBbEfUtgOqVWk0Htik3J/w@public.gmane.org>

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
RK5CYII=

--Apple-Mail=_9C71749E-CEEB-4BDE-B8E0-5106C23A460D--

--Apple-Mail=_66978017-B996-40E7-8969-E11BC35A7BA4--

--===============0388400964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0388400964==--
