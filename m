From: Sage Weil <sage@inktank.com>
Subject: Re: Ceph packaging in Debian GNU/Linux
Date: Mon, 11 Jun 2012 15:56:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206111540050.18906@cobra.newdream.net>
References: <4FD31B72.6080603@enovance.com> <1339238422.7726.23.camel@julia>
 <4FD3522E.1040007@enovance.com> <1339254119.7726.28.camel@julia>
 <4FD4914A.4080409@enovance.com> <1339453334.7726.61.camel@julia>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44183 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab2FKW5T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 18:57:19 -0400
In-Reply-To: <1339453334.7726.61.camel@julia>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Cc: Loic Dachary <loic@enovance.com>, sage@newdream.net, openstack-devel@lists.alioth.debian.org, ceph-devel@vger.kernel.org

Hi Laszlo,

On Mon, 11 Jun 2012, Laszlo Boszormenyi (GCS) wrote:
> Hi Loic, Sage,
> 
> On Sun, 2012-06-10 at 14:21 +0200, Loic Dachary wrote:
> > On 06/09/2012 05:01 PM, Laszlo Boszormenyi (GCS) wrote:
> > > On Sat, 2012-06-09 at 15:39 +0200, Loic Dachary wrote:
> > >> Amazingly quick answer ;-) Did you build from sources or using the packages provided by ceph themselves ?
> > >  It's not that short to answer. I'm a DD and thus, I do my packages. Try
> > > not to diverge much from their packages, so sometimes I send patches to
> > > them. But you have to note, we have different objectives. They build for
> > > stable releases, I do it for Sid, targeting Wheezy.
> > Maybe they changed their policy because I used the packages they built for wheezy successfully. Are there many differences between yours and theirs ?
>  Well, a bit strange that you could build their stable packages on
> Wheezy, but not that impossible. Please note, that they favor Ubuntu, at
> least the ceph-kdump-copy package is a nonsense on Debian.

I can separate that out... we just needed it for our qa infrastructure.  

> About changes, see the attached patches for example. Upstream list
> python build-dependency twice, the first can be deleted and list an
> empty recommends line. It's better to run configure in its own target,
> as seen in the second patch.

Fixed/applied both, thanks!

> One of its build dependency, leveldb is not buildable on several
> platforms. Thus a
> sed -i "s/Architecture: linux-any/Architecture: amd64 armel armhf i386 ia64 mipsel/" debian/control
> is needed on their tree.

Fixed.

>  You asked if I need help with packaging. Only test that it's buildable.
> First is libs3 [1], I could test it on amd64 only. The second is ceph
> itself[2]. Could test it on amd64, interested about builds on armel,
> armhf, i386, ia64 or mipsel. Losing users on mips, powerpc, s390, s390x
> and sparc, due to leveldb not buildable on them.

>  Sage, please be honest. How do you choose other projects to depend on?
> It's clear that leveldb doesn't have any stable release, only a git
> tree. Checking the Debian build logs, it's also known that it doesn't
> build on several arches. Its maintainer tries porting it to those, and
> it contains his work that it's buildable on others.

leveldb doesn't have official releases or tidy release management, but the 
library is better than the alternatives, so it's worth the overhead for 
us to make it consumable.  I think that's reflected by the fact that it is 
now packaged, and is being actively used by several other projects 
(notably riak).

> Checking the other external dependency, libs3. It seems to be abandoned
> since 2008, according to Amazon itself[3]. As I can't access its git
> tree[4], I don't know otherwise.

libs3 was a difficult choice.  It is abandoned, but it also appears to be 
the best option for a native C S3 client library.  If someone knows of 
another, we're all ears, but in the meantime libs3 works. 

Also, notably, it is only used for rest-bench, a simple benchmarking tool.  
For the Debian packages, you are free to configure --without-rest-bench.  
It shares a bunch of code with the 'rados bench' command, so it's nice to 
have it together in the ceph source package.

Thanks!
sage
