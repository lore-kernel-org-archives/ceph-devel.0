From: Christian Balzer <chibi-FW+hd8ioUD0@public.gmane.org>
Subject: Re: Deprecating ext4 support
Date: Tue, 12 Apr 2016 08:39:25 +0900
Message-ID: <20160412083925.5106311d@batzmaru.gol.ad.jp>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1604111632520.13448-Wo5lQnKln9t9PHm/lf2LFUEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-announce-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


Hello,

What a lovely missive to start off my working day...

On Mon, 11 Apr 2016 17:39:37 -0400 (EDT) Sage Weil wrote:

> Hi,
> 
> ext4 has never been recommended, but we did test it.  
Patently wrong, as Shinobu just pointed.

Ext4 never was (especially recently) flogged as much as XFS, but it always
was a recommended, supported filestorage filesystem, unlike the
experimental BTRFS of ZFS. 
And for various reasons people, including me, deployed it instead of XFS.

> After Jewel is
> out, we would like explicitly recommend *against* ext4 and stop testing
> it.
> 
Changing your recommendations is fine, stopping testing/supporting it
isn't. 
People deployed Ext4 in good faith and can be expected to use it at least
until their HW is up for replacement (4-5 years).

> Why:
> 
> Recently we discovered an issue with the long object name handling that
> is not fixable without rewriting a significant chunk of FileStores
> filename handling.  (There is a limit in the amount of xattr data ext4
> can store in the inode, which causes problems in LFNIndex.)
> 
Is that also true if the Ext4 inode size is larger than default?

> We *could* invest a ton of time rewriting this to fix, but it only
> affects ext4, which we never recommended, and we plan to deprecate
> FileStore once BlueStore is stable anyway, so it seems like a waste of
> time that would be better spent elsewhere.
> 
If you (that is RH) is going to declare bluestore stable this year, I
would be very surprised.
Either way, dropping support before the successor is truly ready doesn't
sit well with me.

Which brings me to the reasons why people would want to migrate (NOT
talking about starting freshly) to bluestore.

1. Will it be faster (IOPS) than filestore with SSD journals? 
Don't think so, but feel free to prove me wrong.

2. Will it be bit-rot proof? Note the deafening silence from the devs in
this thread: 
http://www.spinics.net/lists/ceph-users/msg26510.html

> Also, by dropping ext4 test coverage in ceph-qa-suite, we can 
> significantly improve time/coverage for FileStore on XFS and on
> BlueStore.
> 
Really, isn't that fully automated?

> The long file name handling is problematic anytime someone is storing 
> rados objects with long names.  The primary user that does this is RGW, 
> which means any RGW cluster using ext4 should recreate their OSDs to use 
> XFS.  Other librados users could be affected too, though, like users 
> with very long rbd image names (e.g., > 100 characters), or custom 
> librados users.
> 
> How:
> 
> To make this change as visible as possible, the plan is to make ceph-osd 
> refuse to start if the backend is unable to support the configured max 
> object name (osd_max_object_name_len).  The OSD will complain that ext4 
> cannot store such an object and refuse to start.  A user who is only
> using RBD might decide they don't need long file names to work and can
> adjust the osd_max_object_name_len setting to something small (say, 64)
> and run successfully.  They would be taking a risk, though, because we
> would like to stop testing on ext4.
> 
> Is this reasonable?  
About as reasonable as dropping format 1 support, that is not at all.
https://www.mail-archive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg28070.html

I'm officially only allowed to do (preventative) maintenance during weekend
nights on our main production cluster. 
That would mean 13 ruined weekends at the realistic rate of 1 OSD per
night, so you can see where my lack of enthusiasm for OSD recreation comes
from.

> If there significant ext4 users that are unwilling
> to recreate their OSDs, now would be the time to speak up.
> 
Consider that done.

Christian
-- 
Christian Balzer        Network/Systems Engineer                
chibi-FW+hd8ioUD0@public.gmane.org   	Global OnLine Japan/Rakuten Communications
http://www.gol.com/
