Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91DC35A938
	for <ceph-devel@vger.kernel.org>; Tue, 24 Mar 2026 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385658; cv=none; b=GA7gf0KrmvSx1lohmbELDFhcyPgL9xJf3GZi0YmZe95C3yxtZJoOLykdCMJHmzevgOwMOv9XgU4rmSJCA+3/28lSo1LX3IbBixu2iNlsbRp2UUyRyqbcVDLcXQ3CLZetqPTjYQyn+2UfJiEVgsPL3zfcDgL4PrYX6ujTVesA55A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385658; c=relaxed/simple;
	bh=YLz6uSmqoShYeeRXY1+z3t1X794Ak/CPp1kM4sr09Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CiQOp2efHDItr+Jodkt4vzYCGPF7H1TUym0jwTBgBhuCLcXVP7vvvhOd6kE3zIKBKGAd89TJJXU117wYm0NlKt6hiJBR+Lgh/l+FTTuEpXDRld4rDrpU7waVgLQPZuDBuDH3pGStKIOrVKRbWBO6a/QyEDjjLIctRyedVjDcP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RW4n7vLe; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW4n7vLe"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so3088810eec.1
        for <ceph-devel@vger.kernel.org>; Tue, 24 Mar 2026 13:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774385656; x=1774990456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GV/Le0LYBfD23tTmCrTD0oDiRR7WCUFJTnltlnUdhoY=;
        b=RW4n7vLeQVsKTOf4HsWTAgd0aB4LgeO9g11RpE+UmNfeFivG4Ap6wo6t847wWsiKUA
         j1xG6RI3b4kfPmRP4KmfyFRnHFkIws9f9Ev4bzQ+VCQ2mIZn7jcj+sco7XoSfvvLUK/v
         yTdvL48lA9cOwxx8JtzfYPIDQryCX5Yr5Ibv1h+1ADB+GoOwTfCeDJtzExMdEIztgrC7
         N+93pAP3XaiOXTvrRfXw1LiX0bdvDrX2cHz7L8xLhwA61ITRC5CEcNmDiFgmhY5UJy6k
         iVjZuV6zFNHuYplFdbBenM8ol2Ope06nQbYSQyPfcUjpCT9P4Ok2CDEvIWrta1IESJFx
         2diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774385656; x=1774990456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GV/Le0LYBfD23tTmCrTD0oDiRR7WCUFJTnltlnUdhoY=;
        b=gycJ8YwXNCJkfA1kdsDKmDfS0Xys3P2bLsb/iGkcqfQAPp4ZJHYzKh3afdwpJGEUur
         QzQTWUeNGL6SKKPV7eLNznKCBHN4aQCPh7CX3yG29n75IYYPTcq/Rg1uURz7cL8I9fHn
         XSe+edmfmigXYlj8kHEf51dvh1FFQts3S0v2KhoCpbnwKKO+8LP+G5937nicROjzmUhV
         8+qMCh+f3s0Dj5hvzZk3/SPbIh68zPlOthEetN1DrAeFCkn6xKW4xHADiFOp2c4C9cZ/
         VqIo5m9PvTeHESO5oneD1Nyl8JJbjXbrs/45GBmVzxOpYml/JEIRIOAKBjRQP+rVis2U
         3snw==
X-Forwarded-Encrypted: i=1; AJvYcCUg8F/mCxX8pAC6T99+JTgdpxfeOSKmnPW3RM/LzSwChOmoBxW2LaebZ+sAoEZPn31zO+6dLDE5vLw4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw42qbpAVsPzd0eq3kkxxJpT6SqM5sweSBrboqm/i1gP43yE/Ut
	hzOp3o6HKEEYFth62/x8iIJh7a0acvLwDrhewlsHdRi2FeM60QTbq6aT
X-Gm-Gg: ATEYQzwpZcsFSUXvs8274U/MFJTfa6XbDd0MNc92webLGe3PbA6zFt2MCGyNepxaQSy
	GKE20WH9QdztmH+gNXxmAwEJqlTki/Te+AVLLGA4xuVdI66UV1g9jR2h/xXBcGtbK1qecXSl1PL
	BHzRKrmJlbqA/TE3eVxNd2qhQXh0JiN9ZZYR097pn1VMGHxIazyyk9xsmZOFZjwdkT1pnL3O3sI
	kqlgcmO1wfVGjvVyl1YubgsZa+s64OmsghNjKOrrxKPkhA6Yti2NxKUJfCu94Yn/s/OHJcE5ns/
	VNQtwnkLH/h8o0uNDXJOy5SJQPxfqLQu5IW03HTdIqOou5P0hyb6KwdcSMjpw60F1zxvD5MYDZd
	2SRYIv1LDqCRZWfVYTjYxhw/2kjY8ArH6+HNRfhwKeSeBpFIY9DOTXFnBbmWdhaOzZS4jspWeM4
	RBXYVbWEkuq32FhA63Usu62NQbZbJqgVJ2ynU1Q/d3YSjq6/JrHrS1MnaIph/SCtTBcMS9vFx0N
	g==
X-Received: by 2002:a05:7300:e427:b0:2c0:c775:a46b with SMTP id 5a478bee46e88-2c15d2fed07mr465631eec.8.1774385655399;
        Tue, 24 Mar 2026 13:54:15 -0700 (PDT)
Received: from [192.168.68.191] (67-2-26-43.slkc.qwest.net. [67.2.26.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b14cadbsm19529863eec.3.2026.03.24.13.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 13:54:14 -0700 (PDT)
Message-ID: <b1da3970-306f-4345-bace-7101a39874f9@gmail.com>
Date: Tue, 24 Mar 2026 14:54:13 -0600
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ceph-users] Cephfs kernel client bug report
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 Venky Shankar <vshankar@redhat.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
References: <0100019cfdd4fb2d-5355e1f0-8561-4826-a592-16093c7bc4de-000000@email.amazonses.com>
 <CACPzV1=Fz9Qxu2hT=23wApZjW=m2DBtDx__g=wE8Pgy=9k98aA@mail.gmail.com>
 <2106322c86b05486ecf34b35198a644e112aac23.camel@ibm.com>
 <a7d899ba-1e42-4a78-8835-f89a01d10328@gmail.com>
 <01a85528e6a81df3388a80778cd4c014c4def417.camel@ibm.com>
Content-Language: en-US
From: Alain Bertrand <the.roger.thornhill@gmail.com>
In-Reply-To: <01a85528e6a81df3388a80778cd4c014c4def417.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Slava,

Thank you for taking time to look into it.  I am sorry it took a while 
to get back to you, I had some struggles building the patched kernel (I 
am not a developer).  I had to build 6.17.13-2-pve because I couldn't 
make 6.17.13-1-pve, so I first checked that the default 6.17.13-2-pve 
still has the problem, and then tested that the rebuilt kernel with that 
patch works.  That patch does indeed fix it.  I was able to list out the 
snapshot directory of about 4 times as many directories without any 
problems, and I repeated that test many  times just to be sure it wasn't 
just luck.

I am sorry to have bothered you with something that was already fixed, I 
didn't see that conversation while looking to see if this was already 
reported.  Would you like me to update the bug report to say that this 
patch fixes the problem I reported?

BTW, I want to take a moment to thank you for your work.  I am sure you 
don't get thanked enough for working hard making things better for all 
of us.


Thanks,

Alain


On 2026-03-23 12:44, Viacheslav Dubeyko wrote:
> Hi Alain,
>
> On Wed, 2026-03-18 at 16:38 -0600, Alain Bertrand wrote:
>> Slava,
>>
>> I just put the details in the bug
>> report https://urldefense.proofpoint.com/v2/url?u=https-3A__tracker.ceph.com_issues_75609&d=DwIDaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=q5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=l3Zx9FbG-WJdrbXCbJZPxTTB-kIMC3ZBXxTv7IVCvuh9iCYcgqxMnu9WakaH-0bO&s=fmKB-I_ZRE5nnjiPqAFOQmJsNjp1ay1dzoWM7kKqxwg&e=  .  The kernels I was able
>> to reproduce the issue on were the proxmox supplied 6.17.13-1-pve, and
>> 6.14.11-5-pve, and the Pop!_OS kernel version 6.18.7-76061807-generic.
>> The problem didn't happen on a different machine running CachyOS kernel
>> 6.19.6-2-cachyos.
>>
>> All I needed to do to reproduce the problem was go to the cephfs
>> mountpoint (/mnt/ceph) and run find -maxdepth 3 -type d -exec ls
>> "{}/.snap/" \; which should have listed snapshots from about 1015
>> directories.  This wasn't the smartest way to find snapshots, it was
>> just the first one I thought of.
>>
>> Each time the effect is a little different.  Sometimes it immediately
>> panics, sometimes the machine just gets slow for a few minutes with lots
>> of errors being logged before it panics.
>>
>>
> As far as I can see, you have 6.17.13-1-pve kernel version. And you have this
> crash as reported first:
>
> 2026-03-10T17:08:36.865704-06:00 ti kernel: Oops: general protection fault,
> probably for non-canonical address 0xe512d51cad6e7b3f: 0000 [#1] SMP PTI
> 2026-03-10T17:08:36.865745-06:00 ti kernel: CPU: 2 UID: 0 PID: 2450314 Comm:
> kworker/2:0 Tainted: P O 6.17.13-1-pve #1 PREEMPT(voluntary)
> 2026-03-10T17:08:36.865750-06:00 ti kernel: Tainted: [P]=PROPRIETARY_MODULE,
> [O]=OOT_MODULE
> 2026-03-10T17:08:36.865773-06:00 ti kernel: Hardware name: Supermicro Super
> Server/X10SRM-TF, BIOS 3.4 06/09/2021
> 2026-03-10T17:08:36.865776-06:00 ti kernel: Workqueue: ceph-msgr ceph_con_workfn
> [libceph]
> 2026-03-10T17:08:36.865781-06:00 ti kernel: RIP:
> 0010:__kmalloc_node_track_caller_noprof+0x176/0x510
> 2026-03-10T17:08:36.865785-06:00 ti kernel: Code: 03 0f b6 91 60 cc 55 b5 e9 29
> ff ff ff 4d 85 c0 74 91 48 85 db 74 8c bf ff ff ff ff 41 8b 45 28 49 8b 75 00 4c
> 01 c0 48 89 c1 <48> 8b 00 49 33 85 b8 00 00 00 48 0f c9 48 31 c8 48 8d 8a 00 20
> 00
> 2026-03-10T17:08:36.865823-06:00 ti kernel: RSP: 0018:ffffca16a9def810 EFLAGS:
> 00010286
> 2026-03-10T17:08:36.865826-06:00 ti kernel: RAX: e512d51cad6e7b3f RBX:
> ffffed3ac4045b80 RCX: e512d51cad6e7b3f
> 2026-03-10T17:08:36.865836-06:00 ti kernel: RDX: 0000000182e28002 RSI:
> ffffffffb66b2de0 RDI: 00000000ffffffff
> 2026-03-10T17:08:36.865838-06:00 ti kernel: RBP: ffffca16a9def870 R08:
> e512d51cad6e7b1f R09: 0000000000000000
> 2026-03-10T17:08:36.865840-06:00 ti kernel: R10: ffffca16a9def890 R11:
> 0000000000000025 R12: 0000000000000025
> 2026-03-10T17:08:36.865842-06:00 ti kernel: R13: ffff892d8004af00 R14:
> 00000000ffffffff R15: 0000000000000cc0
> 2026-03-10T17:08:36.865844-06:00 ti kernel: FS: 0000000000000000(0000)
> GS:ffff894cc9286000(0000) knlGS:0000000000000000
> 2026-03-10T17:08:36.865846-06:00 ti kernel: CS: 0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> 2026-03-10T17:08:36.865848-06:00 ti kernel: CR2: 00007f48068999a4 CR3:
> 000000033e42a005 CR4: 00000000003726f0
> 2026-03-10T17:08:36.865850-06:00 ti kernel: Call Trace:
> 2026-03-10T17:08:36.865852-06:00 ti kernel: <TASK>
> 2026-03-10T17:08:36.865854-06:00 ti kernel: ? parse_longname+0x5c/0x270 [ceph]
> 2026-03-10T17:08:36.865863-06:00 ti kernel: kmemdup_nul+0x3b/0xb0
> 2026-03-10T17:08:36.865865-06:00 ti kernel: ? ip_finish_output+0x2b/0x140
> 2026-03-10T17:08:36.865867-06:00 ti kernel: ? kmemdup_nul+0x3b/0xb0
> 2026-03-10T17:08:36.865869-06:00 ti kernel: parse_longname+0x5c/0x270 [ceph]
> 2026-03-10T17:08:36.865871-06:00 ti kernel: ceph_fname_to_usr+0x1e1/0x3a0 [ceph]
> 2026-03-10T17:08:36.865873-06:00 ti kernel: ? cbc_encrypt+0x8a/0xc0
> [aesni_intel]
> 2026-03-10T17:08:36.865881-06:00 ti kernel: ? crypto_skcipher_encrypt+0x2d/0x60
> 2026-03-10T17:08:36.865883-06:00 ti kernel: ? ceph_aes_crypt+0x3a3/0x510
> [libceph]
> 2026-03-10T17:08:36.865885-06:00 ti kernel: ? ceph_decode_copy+0x18/0x30 [ceph]
> 2026-03-10T17:08:36.865887-06:00 ti kernel: parse_reply_info+0x4fe/0xab0 [ceph]
> 2026-03-10T17:08:36.865889-06:00 ti kernel: mds_dispatch+0x899/0x2060 [ceph]
> 2026-03-10T17:08:36.865891-06:00 ti kernel: ceph_con_process_message+0x7d/0x160
> [libceph]
> 2026-03-10T17:08:36.865893-06:00 ti kernel: ?
> ceph_x_check_message_signature+0x6c/0xd0 [libceph]
> 2026-03-10T17:08:36.865900-06:00 ti kernel: ceph_con_v1_try_read+0x1068/0x1d10
> [libceph]
> 2026-03-10T17:08:36.865902-06:00 ti kernel: ?
> finish_task_switch.isra.0+0x9c/0x340
> 2026-03-10T17:08:36.865904-06:00 ti kernel: ceph_con_workfn+0x2fe/0x660
> [libceph]
> 2026-03-10T17:08:36.865912-06:00 ti kernel: process_one_work+0x18b/0x370
> 2026-03-10T17:08:36.865913-06:00 ti kernel: worker_thread+0x33a/0x480
> 2026-03-10T17:08:36.865915-06:00 ti kernel: ? __pfx_worker_thread+0x10/0x10
> 2026-03-10T17:08:36.865923-06:00 ti kernel: kthread+0x10b/0x220
> 2026-03-10T17:08:36.865925-06:00 ti kernel: ? __pfx_kthread+0x10/0x10
> 2026-03-10T17:08:36.865927-06:00 ti kernel: ret_from_fork+0x208/0x240
> 2026-03-10T17:08:36.865929-06:00 ti kernel: ? __pfx_kthread+0x10/0x10
> 2026-03-10T17:08:36.865931-06:00 ti kernel: ret_from_fork_asm+0x1a/0x30
> 2026-03-10T17:08:36.865933-06:00 ti kernel: </TASK>
> 2026-03-10T17:08:36.865936-06:00 ti kernel: Modules linked in: tcp_diag
> inet_diag veth rbd ceph libceph netfs ebtable_filter ebtables ip6table_raw
> ip6t_REJECT nf_reject_ipv6 ip6table_filter ip6_tables iptable_raw xt_mac
> xt_connmark ipt_REJECT nf_reject_ipv4 xt_set xt_physdev xt_addrtype xt_multiport
> xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_comment xt_tcpudp
> xt_mark iptable_filter ip_set_hash_net ip_set sctp ip6_udp_tunnel udp_tunnel
> rdma_ucm ib_uverbs rdma_cm iw_cm ib_cm target_core_user uio scsi_transport_iscsi
> target_core_mod ib_core nf_tables 8021q garp mrp qrtr bonding tls softdog sunrpc
> binfmt_misc nfnetlink_log dm_crypt sch_fq_codel intel_rapl_msr intel_rapl_common
> intel_uncore_frequency intel_uncore_frequency_common sb_edac
> x86_pkg_temp_thermal intel_powerclamp coretemp zram 842_decompress 842_compress
> lz4hc_compress lz4_compress kvm_intel ipmi_ssif acpi_power_meter kvm ast
> acpi_pad irqbypass acpi_ipmi mei_me ses ipmi_si vga16fb joydev rapl ipmi_devintf
> input_leds enclosure intel_cstate pcspkr vgastate i2c_algo_bit mei
> 2026-03-10T17:08:36.865946-06:00 ti kernel: scsi_transport_sas ipmi_msghandler
> mac_hid zfs(PO) spl(O) vhost_net vhost vhost_iotlb tap msr nvme_fabrics
> efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 usbmouse xfs usbkbd
> btrfs blake2b_generic uas usb_storage hid_generic usbhid hid raid1 dm_raid
> raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq
> nvme nvme_core xhci_pci i2c_i801 nvme_keyring polyval_clmulni
> ghash_clmulni_intel ixgbe i2c_mux nvme_auth ehci_pci i40e lpc_ich xfrm_algo
> ehci_hcd mdio ahci xhci_hcd i2c_smbus ioatdma megaraid_sas libahci libie dca
> libie_adminq wmi aesni_intel
> 2026-03-10T17:08:36.865964-06:00 ti kernel: ---[ end trace 0000000000000000 ]---
> 2026-03-10T17:08:36.933002-06:00 ti kernel: RIP:
> 0010:__kmalloc_node_track_caller_noprof+0x176/0x510
> 2026-03-10T17:08:36.935018-06:00 ti kernel: Code: 03 0f b6 91 60 cc 55 b5 e9 29
> ff ff ff 4d 85 c0 74 91 48 85 db 74 8c bf ff ff ff ff 41 8b 45 28 49 8b 75 00 4c
> 01 c0 48 89 c1 <48> 8b 00 49 33 85 b8 00 00 00 48 0f c9 48 31 c8 48 8d 8a 00 20
> 00
> 2026-03-10T17:08:36.935036-06:00 ti kernel: RSP: 0018:ffffca16a9def810 EFLAGS:
> 00010286
> 2026-03-10T17:08:36.936968-06:00 ti kernel: RAX: e512d51cad6e7b3f RBX:
> ffffed3ac4045b80 RCX: e512d51cad6e7b3f
> 2026-03-10T17:08:36.936978-06:00 ti kernel: RDX: 0000000182e28002 RSI:
> ffffffffb66b2de0 RDI: 00000000ffffffff
> 2026-03-10T17:08:36.937556-06:00 ti kernel: RBP: ffffca16a9def870 R08:
> e512d51cad6e7b1f R09: 0000000000000000
> 2026-03-10T17:08:36.937572-06:00 ti kernel: R10: ffffca16a9def890 R11:
> 0000000000000025 R12: 0000000000000025
> 2026-03-10T17:08:36.938808-06:00 ti kernel: R13: ffff892d8004af00 R14:
> 00000000ffffffff R15: 0000000000000cc0
> 2026-03-10T17:08:36.938819-06:00 ti kernel: FS: 0000000000000000(0000)
> GS:ffff894cc9286000(0000) knlGS:0000000000000000
> 2026-03-10T17:08:36.939981-06:00 ti kernel: CS: 0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> 2026-03-10T17:08:36.939998-06:00 ti kernel: CR2: 00007f48068999a4 CR3:
> 000000033e42a005 CR4: 00000000003726f0
> 2026-03-10T17:08:40.218090-06:00 ti there is no tcmu-runner data available
>
> This crash reminds me the fix [1]. Could you please check that this fix resolves
> (or not) the issue on your side?
>
> You reported several crashes. So, potentially, other ones can be side effects of
> the same issue. Or, maybe, you, have several issues on your side. Let's check
> everything step by step.
>
> Sorry, I had crash of my system last week. So, I was out of normal routine
> several days.
>
> Thanks,
> Slava.
>
> [1]
> https://lore.kernel.org/ceph-devel/CAOi1vP8w1si2kdL7jY3LOh35k6H9JQU6ck0B81OQFJt6eFV6qQ@mail.gmail.com/
