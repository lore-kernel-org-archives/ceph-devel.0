From: Dan van der Ster <dan@vanderster.com>
Subject: Re: CDS blueprint: strong auth for cephfs
Date: Fri, 15 Nov 2013 09:42:04 +0100
Message-ID: <CABZ+qqkt3HskznC8etcbx5VhQu+SbnwOUh62oXn+c6O0Q4WWsw@mail.gmail.com>
References: <CABZ+qqkfhMFUskDheNrARKfyUPCRLref-O=kkw3ezqaZFnu6rw@mail.gmail.com>
 <CAPYLRzgrDPUg91em1uXkCtqFfbS-2GP92stjmGtPUOmS+tRcTw@mail.gmail.com>
 <CABZ+qq=SQman+HPvKany0HigYrtMn766itdU_7ZsYm6SOaQzcQ@mail.gmail.com> <l63als$lk4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:63009 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab3KOImq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Nov 2013 03:42:46 -0500
Received: by mail-bk0-f49.google.com with SMTP id w14so1751062bkz.8
        for <ceph-devel@vger.kernel.org>; Fri, 15 Nov 2013 00:42:45 -0800 (PST)
Received: from mail-la0-x232.google.com (mail-la0-x232.google.com [2a00:1450:4010:c03::232])
        by mx.google.com with ESMTPSA id l5sm6175743bko.7.2013.11.15.00.42.44
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Nov 2013 00:42:44 -0800 (PST)
Received: by mail-la0-f50.google.com with SMTP id el20so2476451lab.37
        for <ceph-devel@vger.kernel.org>; Fri, 15 Nov 2013 00:42:44 -0800 (PST)
In-Reply-To: <l63als$lk4$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Alex,
The problem is that the cephx keyring would still be needed on
untrusted hosts. With that, anyone can delete/corrupt the underlying
objects (though they may be encrypted) using rados.
Cheers, Dan

On Thu, Nov 14, 2013 at 9:09 PM, Alex Elsayed <eternaleye@gmail.com> wrote:
> Dan van der Ster wrote:
>
>> Hi Greg,
> <snip>
>> AFAICT, this would allow single users to mount a subtree on CephFS and
>> prevent them from writing where they are not permitted. But our
>> use-case is different: we want to mount /cephfs/ from shared
>> workstations and batch nodes to store personal home directories,
>> shared group areas, and read-only software areas. Managing per-user
>> keyrings and per-user mountpoints would become quickly unmanageable.
> <snip>
>
> Actually, there are a number of ways this could be managed pretty reasonably
> - eCryptfs, in particular, may be worth examining. It ships with a
> pam_ecryptfs module that (on login) uses the login password to produce the
> decryption key, and load it into the user's session keyring (which is then
> associated with every process in that session, although I don't think
> eCryptfs uses that). It then mounts the eCryptfs filesystem, and the kernel
> uses the loaded key for decryption.
>
> If the credentials are only used on mount, something similar to pam_ecryptfs
> could work, or a minimal module that _only_ loads the key followed by
> pam_mount.
>
> If the credentials are handled on FS operations, then you'd be able to have
> a single top-level mount with minimal privileges and then use the kernel
> keyring on access.
>
> That also opens up using 'keyctl' to manually load the key into the user or
> session keyring, or using trusted/encrypted keys to allow secure automated
> mounts.
>
> In fact, trusted or encrypted keys could be very useful if someone wanted to
> securely use Ceph as a rootfs - they'd make it possible to authenticate
> mounts based on the hardware, not just the configuration.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
