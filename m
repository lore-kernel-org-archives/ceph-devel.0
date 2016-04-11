From: Jan Schermer <jan@schermer.cz>
Subject: Re: [ceph-users] Deprecating ext4 support
Date: Mon, 11 Apr 2016 23:47:00 +0200
Message-ID: <E6377528-60F6-4A9F-9267-21BDA825EB24@schermer.cz>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com> <CY1PR0201MB1897BE8035001D8D15151EBBE8940@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37116 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbcDKVrG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2016 17:47:06 -0400
Received: by mail-wm0-f45.google.com with SMTP id n3so3523920wmn.0
        for <ceph-devel@vger.kernel.org>; Mon, 11 Apr 2016 14:47:04 -0700 (PDT)
In-Reply-To: <CY1PR0201MB1897BE8035001D8D15151EBBE8940@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Sage Weil <sage@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>, "ceph-announce@ceph.com" <ceph-announce@ceph.com>

RIP Ceph.


> On 11 Apr 2016, at 23:42, Allen Samuels <Allen.Samuels@sandisk.com> wrote:
> 
> RIP ext4.
> 
> 
> Allen Samuels
> Software Architect, Fellow, Systems and Software Solutions 
> 
> 2880 Junction Avenue, San Jose, CA 95134
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
> 
> 
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Sage Weil
>> Sent: Monday, April 11, 2016 2:40 PM
>> To: ceph-devel@vger.kernel.org; ceph-users@ceph.com; ceph-
>> maintainers@ceph.com; ceph-announce@ceph.com
>> Subject: Deprecating ext4 support
>> 
>> Hi,
>> 
>> ext4 has never been recommended, but we did test it.  After Jewel is out,
>> we would like explicitly recommend *against* ext4 and stop testing it.
>> 
>> Why:
>> 
>> Recently we discovered an issue with the long object name handling that is
>> not fixable without rewriting a significant chunk of FileStores filename
>> handling.  (There is a limit in the amount of xattr data ext4 can store in the
>> inode, which causes problems in LFNIndex.)
>> 
>> We *could* invest a ton of time rewriting this to fix, but it only affects ext4,
>> which we never recommended, and we plan to deprecate FileStore once
>> BlueStore is stable anyway, so it seems like a waste of time that would be
>> better spent elsewhere.
>> 
>> Also, by dropping ext4 test coverage in ceph-qa-suite, we can significantly
>> improve time/coverage for FileStore on XFS and on BlueStore.
>> 
>> The long file name handling is problematic anytime someone is storing rados
>> objects with long names.  The primary user that does this is RGW, which
>> means any RGW cluster using ext4 should recreate their OSDs to use XFS.
>> Other librados users could be affected too, though, like users with very long
>> rbd image names (e.g., > 100 characters), or custom librados users.
>> 
>> How:
>> 
>> To make this change as visible as possible, the plan is to make ceph-osd
>> refuse to start if the backend is unable to support the configured max
>> object name (osd_max_object_name_len).  The OSD will complain that ext4
>> cannot store such an object and refuse to start.  A user who is only using
>> RBD might decide they don't need long file names to work and can adjust
>> the osd_max_object_name_len setting to something small (say, 64) and run
>> successfully.  They would be taking a risk, though, because we would like
>> to stop testing on ext4.
>> 
>> Is this reasonable?  If there significant ext4 users that are unwilling to
>> recreate their OSDs, now would be the time to speak up.
>> 
>> Thanks!
>> sage
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

