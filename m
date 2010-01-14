From: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Subject: Re: Problem on ceph configuration
Date: Thu, 14 Jan 2010 09:37:53 -0800
Message-ID: <a37615151001140937x5911e494hddd88fe80439627a@mail.gmail.com>
References: <8C507B5E0BA5114E933C3C6E2E9729E005ECB42098@DEWDFECCR01.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6268100098718489225=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <8C507B5E0BA5114E933C3C6E2E9729E005ECB42098@DEWDFECCR01.wdf.sap.corp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: "Magarshak, Roman" <roman.magarshak@sap.com>
Cc: "ceph-devel@lists.sourceforge.net" <ceph-devel@lists.sourceforge.net>, "Talyansky, Roman" <roman.talyansky@sap.com>
List-Id: ceph-devel.vger.kernel.org

--===============6268100098718489225==
Content-Type: multipart/alternative; boundary=001636ed677cc74626047d2358c8

--001636ed677cc74626047d2358c8
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 14, 2010 at 7:24 AM, Magarshak, Roman
<roman.magarshak@sap.com>wrote:

>  Hi all ,
>
>   We have tried to run ceph on 2 nodes without btrfs and encountered the
> following problem?
>
>
>
> *The system:*
>
> 2 Virtual (on vmware) 32 bit machines , running Debian Lenny  unstable
>
> Both have access to NFS (where the configuration file is kept)
>
>
>
> Kernel version:  2.6.32-trunk-vserver-686
>
> Ceph is installed from tar.gz including kernel and fuse clients (version
> 0.18)
>
> Ceph1=3D10.26.236.93
>
> Ceph2=3D10.26.236.94
>
> On both servers /ceph /ceph/out /ceph/log exists.
>
>
>
> *The scenario: *
>
>
>
> On ceph1 the following commands are executed:
>
> $ mkcephfs --allhosts -c /mnt/nfs/ceph/ceph.conf
>
> $ /etc/init.d/ceph -a -c /mnt/nfs/ceph/ceph.conf start
>
>
>
> After that the cmds , cmon, cosd are running
>
>
>
> Now the following commands on ceph2 are executed:
>
> $ mount -t ceph ceph1:6789:/ /mnt/ceph
>
> The mount succeeds
>
> After =91ls=92 and =91touch=92 commands, the console gets stuck.
>
> Dmesg log  is attached.
>
>
>
> On ceph1 cmds no longer appears on ps.
>
Probably the mds went down for some reason. Maybe there's a core file
around?

Yehuda

--001636ed677cc74626047d2358c8
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote">On Thu, Jan 14, 2010 at=
 7:24 AM, Magarshak, Roman <span dir=3D"ltr">&lt;<a href=3D"mailto:roman.ma=
garshak@sap.com">roman.magarshak@sap.com</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex;">









<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">

<div>

<p class=3D"MsoNormal">Hi all , </p>

<p class=3D"MsoNormal">=A0 We have tried to run ceph on 2 nodes without btr=
fs
and encountered the following problem?</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal"><b>The system:</b></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">2 Virtual (on vmware) =
32 bit
machines , running Debian Lenny=A0 unstable</span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Both have access to NF=
S (where
the configuration file is kept)</span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Kernel version:=A0
2.6.32-trunk-vserver-686</span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Ceph is installed from=
 tar.gz
including kernel and fuse clients (version 0.18)</span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Ceph1=3D10.26.236.93</=
span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Ceph2=3D10.26.236.94</=
span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">On both servers /ceph =
/ceph/out
/ceph/log exists.</span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">=A0</span></p>

<p class=3D"MsoNormal"><b><span style=3D"color:#1F497D">The scenario: </spa=
n></b></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">On ceph1 the following=
 commands
are executed:</span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">$ mkcephfs --allhosts =
-c /mnt/nfs/ceph/ceph.conf</span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">$ /etc/init.d/ceph -a =
-c
/mnt/nfs/ceph/ceph.conf start</span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">After that the cmds , =
cmon, cosd
are running</span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Now the following comm=
ands on
ceph2 are executed:</span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">$ mount -t ceph ceph1:=
6789:/
/mnt/ceph</span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">The mount succeeds</sp=
an></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">After =91ls=92 and
=91touch=92 commands, the console gets stuck.</span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Dmesg log=A0 is attach=
ed.</span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"color:#1F497D">On ceph1 cmds no longe=
r appears
on ps.</span></p></div></div></blockquote><div>Probably the mds went down f=
or some reason. Maybe there&#39;s a core file around?</div><div><br></div><=
div>Yehuda</div></div></div>

--001636ed677cc74626047d2358c8--


--===============6268100098718489225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
--===============6268100098718489225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============6268100098718489225==--
