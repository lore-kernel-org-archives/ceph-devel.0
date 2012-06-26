From: ming zhang <ming.zhang.china@gmail.com>
Subject: Re: how client handle the errors with OSD and MDS?
Date: Tue, 26 Jun 2012 17:17:19 -0400
Message-ID: <CAGffWzpp=1eRiBm-4dAgTSCWnxCjhH-tLzRDOJSzPTQyzeJ1iA@mail.gmail.com>
References: <CAGffWzo65eSRSr05No8u6hAoJtUwZPDRft5Mj2CbGLF23yfa0Q@mail.gmail.com>
	<Pine.LNX.4.64.1206261044280.17502@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:42021 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab2FZVRU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 17:17:20 -0400
Received: by weyu7 with SMTP id u7so258616wey.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jun 2012 14:17:19 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206261044280.17502@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

This is very good information. Thanks!

Ming


On Tue, Jun 26, 2012 at 1:46 PM, Sage Weil <sage@inktank.com> wrote:
> On Tue, 26 Jun 2012, ming zhang wrote:
>> Hi All
>>
>> I am trying to read the code to understand this.
>>
>> A scenario like this.
>>
>> client opens the file and finishes the write with OSD. But for some
>> reason Client could not contact MDS and fails to update MDS. What wi=
ll
>> client do now in order to maintain the rightness of metadata in MDS?
>>
>> Wonder which code this error handling is implemented?
>
> When the client session times out, the MDS will probe the file object=
s to
> recover the file size and mtime. =A0The NEEDSRECOVER flag gets set by
> Locker::revoke_stale_caps() on those files, and they are queued via
> MDCache::queue_file_recover(). =A0You should be able to pick up the t=
rail
> from there.
>
> sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
