From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: fix spelling mistake: "resgister" -> "register"
Date: Fri, 24 Jun 2016 10:15:14 +0800
Message-ID: <359E95D9-1643-49E8-BDBC-23CCA7B047DE@redhat.com>
References: <1466689524-1836-1-git-send-email-colin.king@canonical.com> <1466697671.1847.5.camel@perches.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466697671.1847.5.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Joe Perches <joe@perches.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org


> On Jun 24, 2016, at 00:01, Joe Perches <joe@perches.com> wrote:
> 
> On Thu, 2016-06-23 at 14:45 +0100, Colin King wrote:
>> trivial fix to spelling mistake in pr_err message
> []
>> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> []
>> @@ -71,7 +71,7 @@ int ceph_fscache_register_fs(struct ceph_fs_client* fsc)
>>  					      &ceph_fscache_fsid_object_def,
>>  					      fsc, true);
>>  	if (!fsc->fscache)
>> -		pr_err("Unable to resgister fsid: %p fscache cookie", fsc);
>> +		pr_err("Unable to register fsid: %p fscache cookie", fsc);
> 
> Could change to "cookie\n" to avoid possible interleaving
> from other messages too.

Applied , thanks

Yan, Zheng
