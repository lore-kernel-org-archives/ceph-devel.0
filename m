From: Sha Zhengju <handai.szj@gmail.com>
Subject: Re: [PATCH V6] ceph: use vfs __set_page_dirty_nobuffers interface
 instead of doing it inside filesystem
Date: Thu, 22 Aug 2013 11:07:21 +0800
Message-ID: <CAFj3OHUKx8RnFWdK+4k+AwLsv1PhtFvXRSO+0hcMXQVC_ZXDvw@mail.gmail.com>
References: <1377073654-6232-1-git-send-email-handai.szj@taobao.com>
	<alpine.DEB.2.00.1308210835050.1492@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1308210835050.1492@cobra.newdream.net>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Sage Weil <sage@inktank.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>, Zheng Yan <ukernel@gmail.com>, Michal Hocko <mhocko@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Sha Zhengju <handai.szj@taobao.com>
List-Id: ceph-devel.vger.kernel.org

On Wed, Aug 21, 2013 at 11:35 PM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 21 Aug 2013, Sha Zhengju wrote:
>> Following we will begin to add memcg dirty page accounting around
>> __set_page_dirty_{buffers,nobuffers} in vfs layer, so we'd better use vfs interface to
>> avoid exporting those details to filesystems.
>>
>> Since vfs set_page_dirty() should be called under page lock, here we don't need elaborate
>> codes to handle racy anymore, and two WARN_ON() are added to detect such exceptions.
>> Thanks very much for Sage and Yan Zheng's coaching!
>>
>> I tested it in a two server's ceph environment that one is client and the other is
>> mds/osd/mon, and run the following fsx test from xfstests:
>>
>>   ./fsx   1MB -N 50000 -p 10000 -l 1048576
>>   ./fsx  10MB -N 50000 -p 10000 -l 10485760
>>   ./fsx 100MB -N 50000 -p 10000 -l 104857600
>>
>> The fsx does lots of mmap-read/mmap-write/truncate operations and the tests completed
>> successfully without triggering any of WARN_ON.
>>
>> Signed-off-by: Sha Zhengju <handai.szj@taobao.com>
>
> Reviewed-by: Sage Weil <sage@inktank.com>
>
> Would you like me to take this through the ceph tree?
>

Yes, of course.  : )
BTW I lost my from:    From: Sha Zhengju <handai.szj@taobao.com>

Thank you!

-- 
Thanks,
Sha
