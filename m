From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [PATCH 0/2] Cleanup invalidate page
Date: Fri, 9 Aug 2013 15:43:00 -0400
Message-ID: <CANP1eJEfZuO7cY25Rep+rv-mv89W61=cT=9y7xvhXLsL_h9=8A@mail.gmail.com>
References: <cover.1375686804.git.milosz@adfin.com>
	<alpine.DEB.2.00.1308091044000.12830@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1308091044000.12830@cobra.newdream.net>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Yan, Zheng" <zheng.z.yan@intel.com>
List-Id: ceph-devel.vger.kernel.org

Sage,

Great. Is there some automated testing system that looks for
regressions in cephfs that I can be watching for?

- Milosz

On Fri, Aug 9, 2013 at 1:44 PM, Sage Weil <sage@inktank.com> wrote:
> Hi Milosz,
>
> I pulled both these into the testing branch.  Thanks!
>
> sage
>
> On Fri, 9 Aug 2013, Milosz Tanski wrote:
>
>> Currently ceph_invalidatepage has is overly eger with it's checks which are
>> moot. The second change cleans up the case where offset is non zero.
>>
>> Please pull the from:
>>   https://bitbucket.org/adfin/linux-fs.git wip-invalidatepage
>>
>> This simple patchset came from the changes I made while working on fscache
>> support for cephfs. Per Sage's request I split this up into smaller bites for
>> testing and review.
>>
>> Milosz Tanski (2):
>>   ceph: Remove bogus check in invalidatepage
>>   ceph: cleanup the logic in ceph_invalidatepage
>>
>>  fs/ceph/addr.c | 33 +++++++++++++++------------------
>>  1 file changed, 15 insertions(+), 18 deletions(-)
>>
>> --
>> 1.8.1.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
