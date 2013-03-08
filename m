From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 2/2] fs: fix dentry_lru_prune()
Date: Fri, 08 Mar 2013 10:43:00 +0800
Message-ID: <51395034.40709@intel.com>
References: <1362656256-4397-1-git-send-email-zheng.z.yan@intel.com> <20130308020445.GB23616@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20130308020445.GB23616@dastard>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, sage@inktank.com, viro@zeniv.linux.org.uk
List-Id: ceph-devel.vger.kernel.org

On 03/08/2013 10:04 AM, Dave Chinner wrote:
> On Thu, Mar 07, 2013 at 07:37:36PM +0800, Yan, Zheng wrote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> dentry_lru_prune() should always call file system's d_prune callback.
> 
> Why? What bug does this fix?
> 

Ceph uses a flag to track if the dcache contents for a directory are complete,
and it relies on d_prune() to clear the flag when some dentries are trimmed.
We noticed that dentry_lru_prune() sometimes does not call ceph_d_prune().
It seems the dentry in question is ancestor trimmed by try_prune_one_dentry().

Regards
Yan, Zheng
