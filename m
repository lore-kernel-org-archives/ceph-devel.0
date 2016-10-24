From: Sage Weil <sweil@redhat.com>
Subject: Re: Fw: Questions about bad CRC in KRBD
Date: Mon, 24 Oct 2016 10:26:34 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610241021510.14539@piezo.us.to>
References: <13101b6b-a5b5-47ed-a558-55de6e3119f6.james.liu@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-674909261-1477304585=:14539"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753891AbcJXK0i (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 24 Oct 2016 06:26:38 -0400
In-Reply-To: <13101b6b-a5b5-47ed-a558-55de6e3119f6.james.liu@alibaba-inc.com>
Content-ID: <alpine.DEB.2.11.1610241025190.14539@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "LIU, Fei" <james.liu@alibaba-inc.com>
Cc: idryomov@gmail.com, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-674909261-1477304585=:14539
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.11.1610241025191.14539@piezo.us.to>

Hi James,

On Mon, 24 Oct 2016, LIU, Fei wrote:
> Hi Sage,
>    We built a ceph binary package by ourselves based on Jewel 10.2.2 source
> code in Alibaba. However, 
>    we got below error with krbd/libceph during rbd map with CentOS
> 7.2(Kernel 3.10).  I am still able to use rados  put/fio rbd to put key
> value pairs into the ceph cluster. So , we are kind of confidence that was
> krbd issues.
> 
>    We do disable sign message. 
> 
> cephx_sign_messages = false
> 
> cephx_require_signatures = false
> 
> 
>    And also we make sure we have latest
>  struct ceph_msg_header {
>     __le64 seq;       /* message seq# for this session */
>     __le64 tid;       /* transaction id */
>     __le16 type;      /* message type */
>     __le16 priority;  /* priority.  higher value == higher priority */
>     __le16 version;   /* version of message encoding */
> 
>     __le32 front_len; /* bytes in main payload */
>     __le32 middle_len;/* bytes in middle payload */
>     __le32 data_len;  /* bytes of data payload */
>     __le16 data_off;  /* sender: include full offset;
>                  receiver: mask against ~PAGE_MASK */
> 
>     struct ceph_entity_name src;
>     __le16 compat_version;
>     __le16 reserved;
>     __le32 crc;       /* header crc32c */
> } __attribute__ ((packed));
> 
>   Any help would be appreciated greatly.
>   
>    Regards,
>    James
>    
> 
> [69318.023791] libceph: read_partial_message ffff881fc6140000 signature
> check failed
> 
> [69318.031451] libceph: osd6 11.238.201.173:6824 bad crc

This doesn't sound familiar.  Ilya, have you seen anything like this 
with the centos 7.2 kernel client?

Perhaps you've made some changes from the upstream ceph code and that is 
part of the problem?

sage



> 
> [69318.031826] libceph: read_partial_message ffff881fc6140000 signature
> check failed
> 
> [69318.039492] libceph: osd6 11.238.201.173:6824 bad crc
> 
> [69318.039857] libceph: read_partial_message ffff881fc6140000 signature
> check failed
> 
> [69318.047519] libceph: osd6 11.238.201.173:6824 bad crc
> 
> [69318.047927] libceph: read_partial_message ffff881fc6140000 signature
> check failed
> 
> [69318.055586] libceph: osd6 11.238.201.173:6824 bad crc
> 
> [69318.056009] libceph: read_partial_message ffff881fc6140000 signature
> check failed
> 
> [69318.063754] libceph: osd6 11.238.201.173:6824 bad crc
> 
> [69318.064171] libceph: read_partial_message ffff881fc6140000 signature
> check failed
> 
> [69318.071795] libceph: osd6 11.238.201.173:6824 bad crc
> 
> [69318.072169] libceph: read_partial_message ffff881fc6140000 signature
> check failed
> 
> [69318.079837] libceph: osd6 11.238.201.173:6824 bad crc
> 
> [69318.080306] libceph: read_partial_message ffff881fc6140000 signature
> check failed
> 
> [69318.088052] libceph: osd6 11.238.201.173:6824 bad crc
> 
> [69318.088454] libceph: read_partial_message ffff881fc6140000 signature
> check failed
> 
> [69318.096121] libceph: osd6 11.238.201.173:6824 bad crc
> 
> [69318.096524] libceph: read_partial_message ffff881fc6140000 signature
> check failed
> 
> [69318.104146] libceph: osd6 11.238.201.173:6824 bad crc
> 
> [69318.104558] libceph: read_partial_message ffff881fc6140000 signature
> check failed
> 
> [69318.112226] libceph: osd6 11.238.201.173:6824 bad crc
> 
> [69318.112618] libceph: read_partial_message ffff881fc6140000 signature
> check failed
> 
> [69318.120285] libceph: osd6 11.238.201.173:6824 bad crc
> 
> [69318.120712] libceph: read_partial_message ffff881fc6140000 signature
> check failed
> 
> [69318.128375] libceph: osd6 11.238.201.173:6824 bad crc
> 
> [69318.128761] libceph: read_partial_message ffff881fc6140000 signature
> check failed
> 
> [69318.136380] libceph: osd6 11.238.201.173:6824 bad crc
> 
> [69318.136788] libceph: read_partial_message ffff881fc6140000 signature
> check failed
> 
> [69318.144452] libceph: osd6 11.238.201.173:6824 bad crc
> 
> [69318.144939] libceph: read_partial_message ffff881fc6140000 signature
> check failed
> 
> [69318.152608] libceph: osd6 11.238.201.173:6824 bad crc
> 
> [69318.153026] libceph: read_partial_message ffff881fc6140000 signature
> check failed
> 
> 
>    
> 
> 
> 
> 
--8323329-674909261-1477304585=:14539--
