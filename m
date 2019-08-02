From: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 00/34] put_user_pages(): miscellaneous call sites
Date: Thu, 1 Aug 2019 19:39:00 -0700
Message-ID: <ec87b662-0fc2-0951-1337-a91b4888201b@nvidia.com>
References: <20190802021653.4882-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802021653.4882-1-jhubbard@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, Dave Chinner <david@fromorbit.com>, Dave Hansen <dave.hansen@linux.intel.com>, Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, devel@lists.orangefs.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, linux-mm@kvack.org
List-Id: ceph-devel.vger.kernel.org

On 8/1/19 7:16 PM, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> Hi,
> 
> These are best characterized as miscellaneous conversions: many (not all)
> call sites that don't involve biovec or iov_iter, nor mm/. It also leaves
> out a few call sites that require some more work. These are mostly pretty
> simple ones.
> 
> It's probably best to send all of these via Andrew's -mm tree, assuming
> that there are no significant merge conflicts with ongoing work in other
> trees (which I doubt, given that these are small changes).
> 

In case anyone is wondering, this truncated series is due to a script failure:
git-send-email chokes when it hits email addresses whose names have a
comma in them, as happened here with patch 0003.  

Please disregard this set and reply to the other thread.

thanks,
-- 
John Hubbard
NVIDIA
