From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Fw: Questions about bad CRC in KRBD
Date: Mon, 24 Oct 2016 15:37:49 +0200
Message-ID: <CAOi1vP8gHjV5S5Z8GFO87-vHx8y8-iwrekQC_r_VJnG0knAaBg@mail.gmail.com>
References: <13101b6b-a5b5-47ed-a558-55de6e3119f6.james.liu@alibaba-inc.com> <alpine.DEB.2.11.1610241021510.14539@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:34042 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934306AbcJXNhv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Oct 2016 09:37:51 -0400
Received: by mail-ua0-f181.google.com with SMTP id m26so43072562uaa.1
        for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2016 06:37:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1610241021510.14539@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "LIU, Fei" <james.liu@alibaba-inc.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Oct 24, 2016 at 12:26 PM, Sage Weil <sweil@redhat.com> wrote:
> Hi James,
>
> On Mon, 24 Oct 2016, LIU, Fei wrote:
>> Hi Sage,
>>    We built a ceph binary package by ourselves based on Jewel 10.2.2 source
>> code in Alibaba. However,
>>    we got below error with krbd/libceph during rbd map with CentOS
>> 7.2(Kernel 3.10).  I am still able to use rados  put/fio rbd to put key
>> value pairs into the ceph cluster. So , we are kind of confidence that was
>> krbd issues.
>>
>>    We do disable sign message.
>>
>> cephx_sign_messages = false
>>
>> cephx_require_signatures = false
>>
>>
>>    And also we make sure we have latest
>>  struct ceph_msg_header {
>>     __le64 seq;       /* message seq# for this session */
>>     __le64 tid;       /* transaction id */
>>     __le16 type;      /* message type */
>>     __le16 priority;  /* priority.  higher value == higher priority */
>>     __le16 version;   /* version of message encoding */
>>
>>     __le32 front_len; /* bytes in main payload */
>>     __le32 middle_len;/* bytes in middle payload */
>>     __le32 data_len;  /* bytes of data payload */
>>     __le16 data_off;  /* sender: include full offset;
>>                  receiver: mask against ~PAGE_MASK */
>>
>>     struct ceph_entity_name src;
>>     __le16 compat_version;
>>     __le16 reserved;
>>     __le32 crc;       /* header crc32c */
>> } __attribute__ ((packed));
>>
>>   Any help would be appreciated greatly.
>>
>>    Regards,
>>    James
>>
>>
>> [69318.023791] libceph: read_partial_message ffff881fc6140000 signature
>> check failed
>>
>> [69318.031451] libceph: osd6 11.238.201.173:6824 bad crc
>
> This doesn't sound familiar.  Ilya, have you seen anything like this
> with the centos 7.2 kernel client?
>
> Perhaps you've made some changes from the upstream ceph code and that is
> part of the problem?

Hi James,

"rbd map" doesn't generally parse ceph.conf.  In this case you need to
map with -o nocephx_sign_messages or add it to rbd_default_map_options
config variable, which is a comma-separated list of default map options.

Thanks,

                Ilya
