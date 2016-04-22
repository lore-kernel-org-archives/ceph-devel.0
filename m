From: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: Re: On-going Bluestore Performance Testing Results
Date: Fri, 22 Apr 2016 16:24:42 +0000
Message-ID: <56429BA7-726B-47A2-B608-035671A68E15@sandisk.com>
References: <571A44D0.80704@redhat.com>,
	<4EF91BD6-72DF-49FE-AD0B-B29C677C31A8@schermer.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <4EF91BD6-72DF-49FE-AD0B-B29C677C31A8-SB6/BxVxTjHtwjQa/ONI9g@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Jan Schermer <jan-SB6/BxVxTjHtwjQa/ONI9g@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "cbt-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <cbt-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Yes, kernel should do read ahead , it's a block device setting..but if there is something extra xfs is doing for seq workload , not sure...

Sent from my iPhone

> On Apr 22, 2016, at 8:54 AM, Jan Schermer <jan-SB6/BxVxTjHtwjQa/ONI9g@public.gmane.org> wrote:
>
> Having correlated graphs of CPU and block device usage would be helpful.
>
> To my cynical eye this looks like a clear regression in CPU usage, which was always bottlenecking pure-SSD OSDs, and now got worse.
> The gains are from doing less IO on IO-saturated HDDs.
>
> Regression of 70% in 16-32K random writes is the most troubling, that's coincidentaly the average IO size for a DB2, and the biggest bottleneck to its performance I've seen (other databases will be similiar).
> It's great
>
> Btw readahead is not dependant on filesystem (it's a mechanism in the IO scheduler), so it should be present even on a block device, I think?
>
> Jan
>
>
>> On 22 Apr 2016, at 17:35, Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>
>> Hi Guys,
>>
>> Now that folks are starting to dig into bluestore with the Jewel release, I wanted to share some of our on-going performance test data. These are from 10.1.0, so almost, but not quite, Jewel.  Generally bluestore is looking very good on HDDs, but there are a couple of strange things to watch out for, especially with NVMe devices.  Mainly:
>>
>> 1) in HDD+NVMe configurations performance increases dramatically when replacing the stock CentOS7 kernel with Kernel 4.5.1.
>>
>> 2) In NVMe only configurations performance is often lower at middle-sized IOs.  Kernel 4.5.1 doesn't really help here.  In fact it seems to amplify both the cases where bluestore is faster and where it is slower.
>>
>> 3) Medium sized sequential reads are where bluestore consistently tends to be slower than filestore.  It's not clear yet if this is simply due to Bluestore not doing read ahead at the OSD (ie being entirely dependent on client read ahead) or something else as well.
>>
>> I wanted to post this so other folks have some ideas of what to look for as they do their own bluestore testing.  This data is shown as percentage differences vs filestore, but I can also release the raw throughput values if people are interested in those as well.
>>
>> https://drive.google.com/file/d/0B2gTBZrkrnpZOTVQNkV0M2tIWkk/view?usp=sharing
>>
>> Thanks!
>> Mark
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
