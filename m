From: Jack Culpepper <jackculpepper@gmail.com>
Subject: Re: users, 2.6.34
Date: Wed, 3 Mar 2010 00:27:34 -0800
Message-ID: <261c158e1003030027p71278f92h5a4abd82b5ab6d57@mail.gmail.com>
References: <Pine.LNX.4.64.1003011019020.10267@cobra.newdream.net>
	<20100303011014.f4fb95b3.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20100303011014.f4fb95b3.ctpm@ist.utl.pt>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>, ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

Hey Sager! I am coming off the sidelines! :) I have been poking
through the code for a while but just tried installing for the first
time. Brand new clean debian 5.0.4 installation. The first issue is
the "unauthenticated package" thing, does everyone just hit "y" here?

jack@xyz:~$ sudo apt-get install ceph ceph-kclient-source
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following extra packages will be installed:
  ceph-fuse fuse-utils libceph1 libcrush1 libfuse2 librados1 make
Suggested packages:
  make-doc
The following NEW packages will be installed:
  ceph ceph-fuse ceph-kclient-source fuse-utils libceph1 libcrush1 libfuse2
  librados1 make
0 upgraded, 9 newly installed, 0 to remove and 1 not upgraded.
Need to get 8221kB of archives.
After this operation, 21.4MB of additional disk space will be used.
Do you want to continue [Y/n]?
WARNING: The following packages cannot be authenticated!
  libcrush1 librados1 ceph ceph-fuse ceph-kclient-source libceph1
Install these packages without verification [y/N]?

I hit "y" and continue with the instructions..

jack@xyz:~$ uname -r
2.6.26-2-amd64
jack@xyz:~$ sudo bash
root@xyz:~# apt-get install linux-headers-$(uname -r)
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following extra packages will be installed:
  binutils cpp-4.1 gcc-4.1 gcc-4.1-base libc6-dev linux-headers-2.6.26-2-co=
mmon
  linux-kbuild-2.6.26 linux-libc-dev

root@xyz:~# cd /usr/src/modules/ceph
root@xyz:/usr/src/modules/ceph# make
make: *** No targets specified and no makefile found.  Stop.
root@xyz:/usr/src/modules/ceph#

Hmm, something's weird. No makefile! Also, the README has zero bytes.

root@xyz:/usr/src/modules/ceph# ls -l README NEWS Makefile
ls: cannot access Makefile: No such file or directory
-rw-r--r-- 1 root root 0 2010-03-02 10:59 NEWS
-rw-r--r-- 1 root root 0 2010-03-02 10:59 README
root@xyz:/usr/src/modules/ceph#

But I see those files in the 0.17 distribution I checked out from git
a while back..

l1$ pwd
/home/jack/ceph-0.17/debian/ceph-kclient-source/usr/src/modules/ceph
l1$ ls -l README NEWS Makefile
-rw-r--r-- 1 jack jack 691 Jun  3  2009 Makefile
-rw-r--r-- 1 jack jack   0 Jun  3  2009 NEWS
-rw-r--r-- 1 jack jack 574 Jun  3  2009 README
l1$

Maybe a packaging goof?

Jack

2010/3/2 Cl=E1udio Martins <ctpm@ist.utl.pt>:
>
> On Tue, 2 Mar 2010 11:27:11 -0800 (PST) Sage Weil <sage@newdream.net> wro=
te:
>> Hi,
>>
>> The 2.6.34 merge window is open, and I will be sending another request to
>> Linus shortly asking him to merge the Ceph kernel client. =A0I'd like to=
 be
>> able to accurate describe the current user base and level of interest.
>>
>
> =A0Hi Sage,
>
> =A0FWIW, we will be testing Ceph with 6 or more OSDs a 2~3 MDSs in the
> next 2 months (and beyond). The basic idea is to evaluate Ceph as a
> candidate for future use in a mixed workload university environment with
> several dozens of linux machines (physical and virtual) and multiple
> Samba "gateways" for about 250 Windows workstations.
>
> =A0I'd also like to point out that besides the robustness and performance
> advantages that Ceph should have over an NFSv4 or AFS setup, we are
> especially interested in Kerberos support and ACL support (maybe NFSv4
> equivalent ACLs?), and will be glad to test any features/improvements
> in those areas (an maybe even hack a bit on it, if time permits).
>
> =A0So congratulations for the great work so far, and thanks for sharing
> it with all of us.
>
> Best regards
>
> Cl=E1udio Martins
>
>
> -------------------------------------------------------------------------=
-----
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ceph-devel mailing list
> Ceph-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ceph-devel
>

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
