From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: v0.56 released
Date: Wed, 2 Jan 2013 10:45:46 +0100
Message-ID: <CAOLwVUnYP1HTfimBf2PKBW5TA7gSuKRhsB1u6YPwUQGs633mvg@mail.gmail.com>
References: <alpine.DEB.2.00.1212311721310.1906@cobra.newdream.net>
 <50E39A4E.1060700@conversis.de> <50E39B68.40800@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:41518 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593Ab3ABJqI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jan 2013 04:46:08 -0500
Received: by mail-la0-f42.google.com with SMTP id fe20so5778155lab.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Jan 2013 01:46:06 -0800 (PST)
In-Reply-To: <50E39B68.40800@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Dennis Jacobfeuerborn <dennisml@conversis.de>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

It looks the same for Debian packages, 0.56.1 is on testing branch.

http://ceph.com/debian-testing/dists/precise/main/binary-amd64/Packages

If someone can fix this, thanks in advance ;-)
--
Regards,
S=E9bastien Han.


On Wed, Jan 2, 2013 at 3:28 AM, Mark Nelson <mark.nelson@inktank.com> w=
rote:
> Doh!  Sorry about that.  It looks like they are still in rpm-testing:
>
> http://www.ceph.com/rpm-testing/el6/x86_64/
>
> I imagine Gary will have them in the non-testing repo some time tomor=
row.
>
> Mark
>
>
> On 01/01/2013 08:24 PM, Dennis Jacobfeuerborn wrote:
>>
>> Hi,
>> apparently the RPM link points to version 0.52. Where can the RPMs f=
or
>> 0.56
>> be found?
>>
>> Regards,
>>    Dennis
>>
>> On 01/01/2013 07:02 AM, Sage Weil wrote:
>>>
>>> We're bringing in the new year with a new release, v0.56, which wil=
l form
>>> the basis of the next stable series "bobtail." There is little in t=
he way
>>> of new functionality since v0.55, as we've been focusing primarily =
on
>>> stability, performance, and upgradability from the previous argonau=
t
>>> stable series (v0.48.x). If you are a current argonaut user, you ca=
n
>>> either upgrade now, or watch the Inktank blog for the bobtail
>>> announcement
>>> after some additional testing has been completed. If you are a v0.5=
5 or
>>> v0.55.1 user, we recommend upgrading now.
>>>
>>> Notable changes since v0.55 include:
>>>
>>>   * librbd: fixes for read-only pools for image cloning
>>>   * osd: fix for mixing argonaut and post-v0.54 OSDs
>>>   * osd: some recovery tuning
>>>   * osd: fix for several scrub, recovery, and watch/notify races/bu=
gs
>>>   * osd: fix pool_stat_t backwawrd compatibility with pre-v0.41 cli=
ents
>>>   * osd: experimental split support
>>>   * mkcephfs: misc fixes for fs initialization, mounting
>>>   * radosgw: usage and op logs off by default
>>>   * radosgw: keystone authentication off by default
>>>   * upstart: only enabled with 'upstart' file exists in daemon data
>>>     directory
>>>   * mount.fuse.ceph: allow mounting of ceph-fuse via /etc/fstab
>>>   * config: always complain about config parsing errors
>>>   * mon: fixed memory leaks, misc bugs
>>>   * mds: many misc fixes
>>>
>>> Notable changes since v0.48.2 ("argonaut"):
>>>
>>>   * auth: authentication is now on by default; see release notes!
>>>   * osd: improved threading, small io performance
>>>   * osd: deep scrubbing (verify object data)
>>>   * osd: chunky scrubs (more efficient)
>>>   * osd: improved performance during recovery
>>>   * librbd: cloning support
>>>   * librbd: fine-grained striping support
>>>   * librbd: better caching
>>>   * radosgw: improved Swift and S3 API coverage (POST, multi-object
>>> delete,
>>>     striping)
>>>   * radosgw: OpenStack Keystone integration
>>>   * radosgw: efficient usage stats aggregation (for billing)
>>>   * crush: improvements in distribution (still off by default; see =
CRUSH
>>>     tunables)
>>>   * ceph-fuse, mds: general stability improvements
>>>   * release RPMs for OpenSUSE, SLES, Fedora, RHEL, CentOS
>>>   * tons and bug fixes and small improvements across the board
>>>
>>> If you are upgrading from v0.55, there are no special upgrade
>>> instructions. If you are upgrading from an older version, please re=
ad the
>>> release notes. Authentication is now enabled by default, and if you=
 do
>>> not
>>> adjust your ceph.conf accordingly before upgrading the system will =
not
>>> come up by itself.
>>>
>>> You can get this release from the usual locations:
>>>
>>>   * Git at git://github.com/ceph/ceph.git
>>>   * Tarball at http://ceph.com/download/ceph-0.56.tar.gz
>>>   * For Debian/Ubuntu packages, see
>>> http://ceph.com/docs/master/install/debian
>>>   * For RPMs, see http://ceph.com/docs/master/install/rpm
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
