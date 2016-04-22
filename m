From: Casey Bodley <cbodley@redhat.com>
Subject: Re: memcpy() avoidance using decode(bufferlist)
Date: Fri, 22 Apr 2016 14:05:15 -0400
Message-ID: <571A67DB.6010903@redhat.com>
References: <20160422155355.06c5ef4c@echidna.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37478 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbcDVSFR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Apr 2016 14:05:17 -0400
Received: by mail-ig0-f181.google.com with SMTP id g8so23416096igr.0
        for <ceph-devel@vger.kernel.org>; Fri, 22 Apr 2016 11:05:17 -0700 (PDT)
In-Reply-To: <20160422155355.06c5ef4c@echidna.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>, ceph-devel@vger.kernel.org



On 04/22/2016 09:53 AM, David Disseldorp wrote:
> Hi,
>
> A question regarding bufferlist usage:
>
> I'm working on the cmpext librados C API, and want to decode the OSD
> response directly into a (char *buf/size_t len) buffer provided by the
> caller.
>
> I figured this would be straightforward via:
>    bl.push_back(buffer::create_static(buf, len));
>    ...
>    ::decode_nohead(iter.get_remaining(), bl, iter);
>
> However, the decoded data doesn't make it into buf, unless an extra copy
> occurs via:
>    bl.copy(0, bl.length(), buf);
>
> Any suggestions on a clean way to avoid the extra copy here?
>
> Cheers, David
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi David,

The decode logic is appending data to the end of the given bufferlist, 
which is why it's skipping over the buffer pointer that you provide. 
Internally, buffer::list is allocating its own 'buffer::ptr 
append_buffer' to batch these appends. This append_buffer is not 
currently exposed by the interface, but if there was a way to provide 
your own buffer::ptr from buffer::create_static(), you could 
hypothetically use that to avoid the copy.

Casey
