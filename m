From: Samuel Just <sam.just-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: OpTracker optimization
Date: Wed, 10 Sep 2014 15:25:13 -0700
Message-ID: <CA+4uBUboaU=1uWT7_kNB+ViK0sOOeB4hJKpCVQ397OjWpY83tQ@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2783A845@SACMBXIP02.sdcorp.global.sandisk.com>
	<CA+4uBUbSrYhy8=ZPKZ7dOTh0sNNCs5mC3ttgBH+qoWO+58UdvA@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2783C56D@SACMBXIP02.sdcorp.global.sandisk.com>
	<CA+4uBUbTBksZbRxR9RCTws-O--2N+QnHN5aS_Kx-D7yVeEmiDw@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2783C636@SACMBXIP02.sdcorp.global.sandisk.com>
	<CA+4uBUaaycvVCnjtDCEZO3i9iFB7FifK-+xZwtEcemC7XGPiTg@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2783C65C@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2783C65C-cXZ6iGhjG0i+xgsn/SD5JjJ2aSJ780jGSxCzGc5ayCJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Cc: "Sage Weil (sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org)" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Oh, I changed my mind, your approach is fine.  I was unclear.
Currently, I just need you to address the other comments.
-Sam

On Wed, Sep 10, 2014 at 3:13 PM, Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org> wrote:
> As I understand, you want me to implement the following.
>
> 1.  Keep this implementation one sharded optracker for the ios going through ms_dispatch path.
>
> 2. Additionally, for ios going through ms_fast_dispatch, you want me to implement optracker (without internal shard) per opwq shard
>
> Am I right ?
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Samuel Just [mailto:sam.just-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org]
> Sent: Wednesday, September 10, 2014 3:08 PM
> To: Somnath Roy
> Cc: Sage Weil (sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org); ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> Subject: Re: OpTracker optimization
>
> I don't quite understand.
> -Sam
>
> On Wed, Sep 10, 2014 at 2:38 PM, Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org> wrote:
>> Thanks Sam.
>> So, you want me to go with optracker/shadedopWq , right ?
>>
>> Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Samuel Just [mailto:sam.just-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org]
>> Sent: Wednesday, September 10, 2014 2:36 PM
>> To: Somnath Roy
>> Cc: Sage Weil (sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org); ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> Subject: Re: OpTracker optimization
>>
>> Responded with cosmetic nonsense.  Once you've got that and the other comments addressed, I can put it in wip-sam-testing.
>> -Sam
>>
>> On Wed, Sep 10, 2014 at 1:30 PM, Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org> wrote:
>>> Thanks Sam..I responded back :-)
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> [mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Samuel Just
>>> Sent: Wednesday, September 10, 2014 11:17 AM
>>> To: Somnath Roy
>>> Cc: Sage Weil (sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org); ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>> Subject: Re: OpTracker optimization
>>>
>>> Added a comment about the approach.
>>> -Sam
>>>
>>> On Tue, Sep 9, 2014 at 1:33 PM, Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org> wrote:
>>>> Hi Sam/Sage,
>>>>
>>>> As we discussed earlier, enabling the present OpTracker code
>>>> degrading performance severely. For example, in my setup a single
>>>> OSD node with
>>>> 10 clients is reaching ~103K read iops with io served from memory
>>>> while optracking is disabled but enabling optracker it is reduced to ~39K iops.
>>>> Probably, running OSD without enabling OpTracker is not an option
>>>> for many of Ceph users.
>>>>
>>>> Now, by sharding the Optracker:: ops_in_flight_lock (thus xlist
>>>> ops_in_flight) and removing some other bottlenecks I am able to
>>>> match the performance of OpTracking enabled OSD with OpTracking
>>>> disabled, but with the expense of ~1 extra cpu core.
>>>>
>>>> In this process I have also fixed the following tracker.
>>>>
>>>>
>>>>
>>>> http://tracker.ceph.com/issues/9384
>>>>
>>>>
>>>>
>>>> and probably http://tracker.ceph.com/issues/8885 too.
>>>>
>>>>
>>>>
>>>> I have created following pull request for the same. Please review it.
>>>>
>>>>
>>>>
>>>> https://github.com/ceph/ceph/pull/2440
>>>>
>>>>
>>>>
>>>> Thanks & Regards
>>>>
>>>> Somnath
>>>>
>>>>
>>>>
>>>>
>>>> ________________________________
>>>>
>>>> PLEASE NOTE: The information contained in this electronic mail
>>>> message is intended only for the use of the designated recipient(s)
>>>> named above. If the reader of this message is not the intended
>>>> recipient, you are hereby notified that you have received this
>>>> message in error and that any review, dissemination, distribution,
>>>> or copying of this message is strictly prohibited. If you have
>>>> received this communication in error, please notify the sender by
>>>> telephone or e-mail (as shown above) immediately and destroy any and
>>>> all copies of this message in your possession (whether hard copies or electronically stored copies).
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>> ________________________________
>>>
>>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>>>
