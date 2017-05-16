From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: Why does the heartbeat packet have 122 bytes of messages?
Date: Tue, 16 May 2017 09:41:38 +0200
Message-ID: <e888470f-b73c-4f79-36a9-6324f45712ea@corp.ovh.com>
References: <CAN=xyVVirpj9BsYPB5eMyNy4KrLN6KA+ysTC_29h4aD3rffSdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 2.mo301.mail-out.ovh.net ([137.74.110.65]:39066 "EHLO
        2.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbdEPHlm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 May 2017 03:41:42 -0400
In-Reply-To: <CAN=xyVVirpj9BsYPB5eMyNy4KrLN6KA+ysTC_29h4aD3rffSdA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qi Shi <m13913886148@gmail.com>, ceph-devel@vger.kernel.org

On 05/16/2017 06:50 AM, qi Shi wrote:
> [..snip..]
> But when i look at the code, heartbeat packet is only 9 bytes.
> Here is the code:
> ------------------------------------------------------------------------------------------------------------
> int Pipe::write_keepalive2(char tag, const utime_t& t)
> {
>   ldout(msgr->cct,10) << "write_keepalive2 " << (int)tag << " " << t << dendl;
>   struct ceph_timespec ts;
>   t.encode_timeval(&ts);
>   struct msghdr msg;
>   memset(&msg, 0, sizeof(msg));
>   struct iovec msgvec[2];
>   msgvec[0].iov_base = &tag;
>   msgvec[0].iov_len = 1;
>   msgvec[1].iov_base = &ts;
>   msgvec[1].iov_len = sizeof(ts);
>   msg.msg_iov = msgvec;
>   msg.msg_iovlen = 2;
>
>   if (do_sendmsg(&msg, 1 + sizeof(ts)) < 0)
>     return -1;
>   return 0;
> }
> -----------------------------------------------------------------------------------------------------------------
> "ts" is 8 bytes, and "1+sizeof(ts)" == 9 bytes.
>
>
> My question is why the packet will appear 122 bytes of the message,
> this message is heartbeat message?

The packet that contains ping data is defined in MOSDPing.h, and the code to 
build it looks like this:

   void encode_payload(uint64_t features) override {
     ::encode(fsid, payload);
     ::encode(map_epoch, payload);
     ::encode(peer_as_of_epoch, payload);
     ::encode(op, payload);
     ::encode(peer_stat, payload);
     ::encode(stamp, payload);
   }

fsid is 16 bytes, map_epoch and peer_as_of_epoch is 4 bytes each, op is 1 
byte, peer_stat is 14 bytes (8 bytes data + 6 bytes for extra encoding 
header) and stamp is 8 bytes. This makes 47 bytes of data for MODSDPing 
alone, and you need to include encoding header and probably a bunch of other 
things required by Ceph protocol. Note that there's also MDS heartbeat 
(defined in MHeartbeat.h) that at first glance looks even larger than the 
one above.
Try capturing some packet data, you'll be able to find out what is actually 
transmitted and why it takes that space.

-- 
Piotr Dalek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
