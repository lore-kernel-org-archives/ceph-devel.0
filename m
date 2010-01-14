From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Problem on ceph configuration
Date: Thu, 14 Jan 2010 08:32:37 -0800
Message-ID: <1471eea71001140832m22262096k27bc7ba41188ca31@mail.gmail.com>
References: <8C507B5E0BA5114E933C3C6E2E9729E005ECB42098@DEWDFECCR01.wdf.sap.corp>
	<8C507B5E0BA5114E933C3C6E2E9729E005ECB4211B@DEWDFECCR01.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <8C507B5E0BA5114E933C3C6E2E9729E005ECB4211B@DEWDFECCR01.wdf.sap.corp>
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

Roman:
Problems like this pop up occasionally as we make changes to the
system and it encounters new operating scenarios. Unfortunately, the
list system doesn't pass through attachments -- could you upload them
somewhere (or use pastebin.com) and give us the address?

Alternatively you can try the ceph IRC room (see
http://ceph.newdream.net/mailing-lists-and-irc/). :)
-Greg

On Thu, Jan 14, 2010 at 8:01 AM, Magarshak, Roman
<roman.magarshak@sap.com> wrote:
> Hi all ,
>
> =A0 I=92ve forgot to mention that the problems is , that the kernel clien=
t gets
> stuck and any other mount tries fail.
>
>
>
>
>
> \Roman.
>
>
>
>
>
> Roman Magarshak
> Intern
> SAP Research Israel
> T=A0=A0 +972=A0=A0 9 777 9853
> M=A0 +972 54 464 0910
> E=A0=A0 mailto:roman.magarshak@sap.com
>
>
>
> From: Magarshak, Roman [mailto:roman.magarshak@sap.com]
> Sent: Thursday, January 14, 2010 5:25 PM
> To: ceph-devel@lists.sourceforge.net
> Cc: Talyansky, Roman
> Subject: [LIKELY JUNK][ceph-devel] Problem on ceph configuration
>
>
>
> Hi all ,
>
> =A0 We have tried to run ceph on 2 nodes without btrfs and encountered the
> following problem?
>
>
>
> The system:
>
> 2 Virtual (on vmware) 32 bit machines , running Debian Lenny=A0 unstable
>
> Both have access to NFS (where the configuration file is kept)
>
>
>
> Kernel version:=A0 2.6.32-trunk-vserver-686
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
> The scenario:
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
> Dmesg log=A0 is attached.
>
>
>
> On ceph1 cmds no longer appears on ps.
>
>
>
> Ceph2 console gets stuck, and umount is no longer possible.
>
> Mds logs, configuration files and dmesg logs are attached.
>
>
>
>
>
> Has anyone encountered a similar problem?
>
>
>
>
>
> Thank you in advance for your help.
>
> \Roman
>
> Roman Magarshak
> Intern
> SAP Research Israel
> T=A0=A0 +972=A0=A0 9 777 9853
> M=A0 +972 54 464 0910
> E=A0=A0 mailto:roman.magarshak@sap.com
>
>
>
> -------------------------------------------------------------------------=
-----
> Throughout its 18-year history, RSA Conference consistently attracts the
> world's best and brightest in the field, creating opportunities for
> Conference
> attendees to learn about information security's most important issues
> through
> interactions with peers, luminaries and emerging and established companie=
s.
> http://p.sf.net/sfu/rsaconf-dev2dev
> _______________________________________________
> Ceph-devel mailing list
> Ceph-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ceph-devel
>
>

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
