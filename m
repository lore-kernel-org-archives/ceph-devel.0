From: Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: [ceph-users] ceph-disk is now deprecated
Date: Thu, 30 Nov 2017 12:31:55 +0100
Message-ID: <20171130113155.ce5qu2x34kiqooss@nora.maurer-it.com>
References: <CAC-Np1z7OJNxUeso+FEB8g+7RUABkvKF58_mmXDHt4SeOTHSDw@mail.gmail.com>
 <1821337488.5487.1511856776936@ox.pcextreme.nl>
 <4c4b5589-b1ae-3f8b-e900-af0f2895fbc9@corp.ovh.com>
 <CAC-Np1zsf+uqFi+ZdR7K3=re5ODpJvWFrTX-JU_8DkkyVGOz7A@mail.gmail.com>
 <d548c5a8-c0dc-0737-66f4-e3fc04f900d7@digiware.nl>
 <CAN-Gep+RmSB6gW5GRVsT8T7j60EAzGnfbgeqDjwCNDWocpgp3g@mail.gmail.com>
 <CAKPXa=Yrwpu-hbpOCSsVfq=GyXHTJ9K8iiLKSJuaYDdBpR+_0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from proxmox.maurer-it.com ([212.186.127.180]:32034 "EHLO
        proxmox-new.maurer-it.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751125AbdK3Lb7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Nov 2017 06:31:59 -0500
Content-Disposition: inline
In-Reply-To: <CAKPXa=Yrwpu-hbpOCSsVfq=GyXHTJ9K8iiLKSJuaYDdBpR+_0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vasu Kulkarni <vakulkar@redhat.com>
Cc: David Turner <drakonstein@gmail.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Nov 28, 2017 at 10:39:31AM -0800, Vasu Kulkarni wrote:
> On Tue, Nov 28, 2017 at 9:22 AM, David Turner <drakonstein@gmail.com> wrote:
> > Isn't marking something as deprecated meaning that there is a better option
> > that we want you to use and you should switch to it sooner than later? I
> > don't understand how this is ready to be marked as such if ceph-volume can't
> > be switched to for all supported use cases. If ZFS, encryption, FreeBSD, etc
> > are all going to be supported under ceph-volume, then how can ceph-disk be
> > deprecated before ceph-volume can support them? I can imagine many Ceph
> > admins wasting time chasing an erroneous deprecated warning because it came
> > out before the new solution was mature enough to replace the existing
> > solution.
> 
> There is no need to worry about this deprecation, Its mostly for
> admins to be prepared
> for the changes coming ahead and its mostly for *new* installations
> that can plan on using ceph-volume which provides
> great flexibility compared to ceph-disk.

changing existing installations to output deprecation warnings from one
minor release to the next means it is not just for new installations
though, no matter how you spin it. a mention in the release notes and
docs would be enough to get admins to test and use ceph-volume on new
installations.

I am pretty sure many admins will be bothered by all nodes running OSDs
spamming the logs and their terminals with huge deprecation warnings on
each OSD activation[1] or other actions involving ceph-disk, and having
this state for the remainder of Luminous unless they switch to a new
(and as of yet not battle-tested) way of activating their OSDs seems
crazy to me.

I know our users will be, and given the short notice and huge impact
this would have we will likely have to remove the deprecation warnings
altogether in our (downstream) packages until we have completed testing
of and implementing support for ceph-volume..

> 
> a) many dont use ceph-disk or ceph-volume directly, so the tool you
> have right now eg: ceph-deploy or ceph-ansible
> will still support the ceph-disk, the previous ceph-deploy release is
> still available from pypi
>   https://pypi.python.org/pypi/ceph-deploy

we have >> 10k (user / customer managed!) installations on Ceph Luminous
alone, all using our wrapper around ceph-disk - changing something like
this in the middle of a release causes huge headaches for downstreams
like us, and is not how a stable project is supposed to be run.

> 
> b) also the current push will help anyone who is using ceph-deploy or
> ceph-disk in scripts/chef/etc
>    to have time to think about using newer cli based on ceph-volume

a regular deprecate at the beginning of the release cycle were the
replacement is deemed stable, remove in the next release cycle would be
adequate for this purpose.

I don't understand the rush to shoe-horn ceph-volume into existing
supposedly stable Ceph installations at all - especially given the
current state of ceph-volume (we'll file bugs once we are done writing
them up, but a quick rudimentary test already showed stuff like choking
on valid ceph.conf files because they contain leading whitespace and
incomplete error handling leading to crush map entries for failed OSD
creation attempts).

I DO understand the motivation behind ceph-volume and the desire to get
rid of the udev-based trigger mess, but the solution is not to scare
users into switching in the middle of a release by introducing
deprecation warnings for a core piece of the deployment stack.

IMHO the only reason to push or force such a switch in this manner would
be a (grave) security or data corruption bug, which is not the case at
all here..

1: have you looked at the journal / boot logs of a mid-sized OSD node
using ceph-disk for activation with the deprecation warning active?  if
my boot log is suddenly filled with 20% warnings, my first reaction will
be that something is very wrong.. my likely second reaction when
realizing what is going on is probably not fit for posting to a public
mailing list ;)

