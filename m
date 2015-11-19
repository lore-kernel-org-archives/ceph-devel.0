From: Tejun Heo <tj@kernel.org>
Subject: Re: request_queue use-after-free - inode_detach_wb()
Date: Thu, 19 Nov 2015 17:14:47 -0500
Message-ID: <20151119221447.GB4885@mtj.duckdns.org>
References: <CAOi1vP9igmg_jayELVDq_NYXUHtByZz5a4M5+CqCMMHUxF5ofA@mail.gmail.com>
 <20151117205641.GF22864@mtj.duckdns.org>
 <CAOi1vP_mp6wjb+jU_tRADqhXGqf1YTj=w=3ynMBj5=SaVU3o4g@mail.gmail.com>
 <20151118153039.GA11496@mtj.duckdns.org>
 <CAOi1vP_4aUKVjNqvmFxVGVyaif_zuHdVPjzH5RLOJgYMsSirbA@mail.gmail.com>
 <CAOi1vP-6X7C=3uFNM7SQCe3TZXwrSST1_Tv3Qm0s1SnC2gBs2w@mail.gmail.com>
 <20151119211831.GA4885@mtj.duckdns.org>
 <CAOi1vP9+GvxFLmdOLJYR=hO7QQRcU9tu30vZz=jVLLUwh--7Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOi1vP9+GvxFLmdOLJYR=hO7QQRcU9tu30vZz=jVLLUwh--7Sw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Hello,

On Thu, Nov 19, 2015 at 10:56:43PM +0100, Ilya Dryomov wrote:
> Detaching the inode earlier is what I suggested in the first email, but
> I didn't know if this kind of special casing was OK.  I'll try it out.

Yeah, I was confused.  Sorry about that.  On the surface, it looks
like a special case but everything around bdev is special case anyway
and looking at the underlying lifetime rules, I think this is the
right thing to do.

Thanks.

-- 
tejun
