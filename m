Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80C3DD522
	for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2026 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178501; cv=none; b=r4A3F6O4ZWFsuWRD3vhlMbOfn34wLlGJmmJKXlLg9QohEGhG2kI4pWrV/LEgmRa0ypXCUxT58LwNVULaZeL5ztysqBhtdngYt/eIXIzYTltM5CcNz2VWjJoYGPf9D/eZr8fsinQvrtG2cmr7gov9jj23boB24W4/JQxq6hKKQ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178501; c=relaxed/simple;
	bh=qfeSQzmAksPetc74lzOfbFBmffv9XCfA49G7wmVS6Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2T3YVJ2O63t0UdPkpYsggB5q8ghrt52XAKIBmAZ+TgWluDo3RyqDwAwaAgnD6dECh/CPOXfJdaYvMjISLtcUjizpCHP+sUjW+H8krYKnA6tljcgnye0rxGi5szsIAavsY5LJkyp3px6KnVMwlCeUchWlVCPm4tcVQCXhOMK4vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=o+y+7v0w; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="o+y+7v0w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1773178498; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=qfeSQzmAksPetc74lzOfbFBmffv9XCfA49G7wmVS6Yc=;
 b=o+y+7v0ws/nXAMAmGtj613BiUHC0zS/Ki93TK488z60ys49FRAjnlPE84Zz37pNrcp0+j
 qbAD0FvEla8r75FleGRHhyRNrYmxfdc1iGYn2QGUadq6OHAl/AO5C8pKVPT3iYdwkuMrG4f
 iYX9Zx6jQIkfTBD+bJ/YiVcEGIpXlPSb5fQknIwiEJRAn0BN5tKYEiu1sWrSGYQkSYSmG1K
 2H25/NfG2bGJmXrCwMRywjnW0pwnkZM3YgQQRQVTPYiD/52Ro8axLg6bodgBZ4MV+fBTG1V
 J8W3oGqwtzwrN+EPq7MuHebtsKpw15PMaJOLoHKCGBAdeeyfnlVPJpEgawPw==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 559C95FD88;
	Tue, 10 Mar 2026 22:34:58 +0100 (CET)
Received: from [192.168.178.114] (unknown [217.252.212.162])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 190695FC60;
	Tue, 10 Mar 2026 22:34:58 +0100 (CET)
Message-ID: <eb6789bc-e13f-44ba-b955-8c7703eb78c2@tu-ilmenau.de>
Date: Tue, 10 Mar 2026 22:34:57 +0100
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] libceph: Fix potential out-of-bounds access in
 ceph_handle_auth_reply()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>, ceph-devel@vger.kernel.org
References: <20260310142815.3747443-1-raphael.zimmer@tu-ilmenau.de>
 <CAOi1vP9sVPbZ7yk=Ae85xL9-5mLE=H6iSQYR6-zDcWVQ8afYaA@mail.gmail.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <CAOi1vP9sVPbZ7yk=Ae85xL9-5mLE=H6iSQYR6-zDcWVQ8afYaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/10/26 9:15 PM, Ilya Dryomov wrote:
> On Tue, Mar 10, 2026 at 3:28 PM Raphael Zimmer
> <raphael.zimmer@tu-ilmenau.de> wrote:
>>
>> This patch fixes an out-of-bounds access in ceph_handle_auth_reply()
>> that can be triggered by a message of type CEPH_MSG_AUTH_REPLY. In
>> ceph_handle_auth_reply(), the value of the payload_len field of such a
>> message is stored in a variable of type int. A value greater than
>> INT_MAX leads to an integer overflow and is interpreted as a negative
>> value. This leads to decrementing the pointer address by this value and
>> subsequently accessing it because ceph_decode_need() only checks that
>> the memory access does not exceed the end address of the allocation.
>>
>> This patch fixes the issue by changing the data type of payload_len to
>> u32. Additionally, the data type of result_msg_len is changed to u32,
>> as it is also a variable holding a non-negative length.
>>
>> Also, an additional layer of sanity checks is introduced, ensuring that
>> directly after reading it from the message, payload_len and
>> result_msg_len are not greater than the overall segment length.
>>
>> BUG: KASAN: slab-out-of-bounds in ceph_handle_auth_reply+0x642/0x7a0 [libceph]
>> Read of size 4 at addr ffff88811404df14 by task kworker/20:1/262
>>
>> CPU: 20 UID: 0 PID: 262 Comm: kworker/20:1 Not tainted 6.19.2 #5 PREEMPT(voluntary)
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> Workqueue: ceph-msgr ceph_con_workfn [libceph]
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x76/0xa0
>>   print_report+0xd1/0x620
>>   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>>   ? kasan_complete_mode_report_info+0x72/0x210
>>   kasan_report+0xe7/0x130
>>   ? ceph_handle_auth_reply+0x642/0x7a0 [libceph]
>>   ? ceph_handle_auth_reply+0x642/0x7a0 [libceph]
>>   __asan_report_load_n_noabort+0xf/0x20
>>   ceph_handle_auth_reply+0x642/0x7a0 [libceph]
>>   mon_dispatch+0x973/0x23d0 [libceph]
>>   ? apparmor_socket_recvmsg+0x6b/0xa0
>>   ? __pfx_mon_dispatch+0x10/0x10 [libceph]
>>   ? __kasan_check_write+0x14/0x30i
>>   ? mutex_unlock+0x7f/0xd0
>>   ? __pfx_mutex_unlock+0x10/0x10
>>   ? __pfx_do_recvmsg+0x10/0x10 [libceph]
>>   ceph_con_process_message+0x1f1/0x650 [libceph]
>>   process_message+0x1e/0x450 [libceph]
>>   ceph_con_v2_try_read+0x2e48/0x6c80 [libceph]
>>   ? __pfx_ceph_con_v2_try_read+0x10/0x10 [libceph]
>>   ? save_fpregs_to_fpstate+0xb0/0x230
>>   ? raw_spin_rq_unlock+0x17/0xa0
>>   ? finish_task_switch.isra.0+0x13b/0x760
>>   ? __switch_to+0x385/0xda0
>>   ? __kasan_check_write+0x14/0x30
>>   ? mutex_lock+0x8d/0xe0
>>   ? __pfx_mutex_lock+0x10/0x10
>>   ceph_con_workfn+0x248/0x10c0 [libceph]
>>   process_one_work+0x629/0xf80
>>   ? __kasan_check_write+0x14/0x30
>>   worker_thread+0x87f/0x1570
>>   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>>   ? __pfx_try_to_wake_up+0x10/0x10
>>   ? kasan_print_address_stack_frame+0x1f7/0x280
>>   ? __pfx_worker_thread+0x10/0x10
>>   kthread+0x396/0x830
>>   ? __pfx__raw_spin_lock_irq+0x10/0x10
>>   ? __pfx_kthread+0x10/0x10
>>   ? __kasan_check_write+0x14/0x30
>>   ? recalc_sigpending+0x180/0x210
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork+0x3f7/0x610
>>   ? __pfx_ret_from_fork+0x10/0x10
>>   ? __switch_to+0x385/0xda0
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork_asm+0x1a/0x30
>>   </TASK>
>>
>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>> ---
>>   net/ceph/auth.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ceph/auth.c b/net/ceph/auth.c
>> index d38c9eadbe2f..ee85c5e45773 100644
>> --- a/net/ceph/auth.c
>> +++ b/net/ceph/auth.c
>> @@ -205,9 +205,9 @@ int ceph_handle_auth_reply(struct ceph_auth_client *ac,
>>          s32 result;
>>          u64 global_id;
>>          void *payload, *payload_end;
>> -       int payload_len;
>> +       u32 payload_len;
>>          char *result_msg;
>> -       int result_msg_len;
>> +       u32 result_msg_len;
>>          int ret = -EINVAL;
>>
>>          mutex_lock(&ac->mutex);
>> @@ -217,10 +217,14 @@ int ceph_handle_auth_reply(struct ceph_auth_client *ac,
>>          result = ceph_decode_32(&p);
>>          global_id = ceph_decode_64(&p);
>>          payload_len = ceph_decode_32(&p);
>> +       if (payload_len > len)
>> +               goto bad;
> 
> Hi Raphael,
> 
> Using ceph_decode_need() would be preferred for consistency with
> e.g. process_auth_reply_more() and other code:
> 
>    -       if (payload_len > len)
>    -               goto bad;
>    +       ceph_decode_need(&p, end, payload_len, bad);
> 
> If it's fine with you, I can make this change when applying the patch
> to save another posting.
> 
> Thanks,
> 
>                  Ilya

Hi Ilya,
I'm fine with this. You can change these two checks to ceph_decode_need.

Best regards,
Raphael
