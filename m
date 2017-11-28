From: Joao Eduardo Luis <joao-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ceph-disk is now deprecated
Date: Tue, 28 Nov 2017 14:17:20 +0000
Message-ID: <5a21d992-e360-66ce-5b72-743a05b59a1a@suse.de>
References: <CAC-Np1z7OJNxUeso+FEB8g+7RUABkvKF58_mmXDHt4SeOTHSDw@mail.gmail.com>
 <1821337488.5487.1511856776936@ox.pcextreme.nl>
 <CAC-Np1zfMoqtW2M75ZAys1_NTEkns6MJ6HimuRR3nFhbMVzjPg@mail.gmail.com>
 <1db3fa50-d022-bf37-eb4b-098882ea0984@suse.de>
 <CAC-Np1ynRyeOChGK2k_oBAx0A7XcAFkMDMrxVHZhN-pjGXfAJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAC-Np1ynRyeOChGK2k_oBAx0A7XcAFkMDMrxVHZhN-pjGXfAJw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 11/28/2017 12:52 PM, Alfredo Deza wrote:
> On Tue, Nov 28, 2017 at 7:38 AM, Joao Eduardo Luis <joao-l3A5Bk7waGM@public.gmane.org> wrote:
>> On 11/28/2017 11:54 AM, Alfredo Deza wrote:
>>>
>>> On Tue, Nov 28, 2017 at 3:12 AM, Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org> wrote:
>>>>
>>>>
>>>>> Op 27 november 2017 om 14:36 schreef Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
>>>>>
>>>>>
>>>>> For the upcoming Luminous release (12.2.2), ceph-disk will be
>>>>> officially in 'deprecated' mode (bug fixes only). A large banner with
>>>>> deprecation information has been added, which will try to raise
>>>>> awareness.
>>>>>
>>>>
>>>> As much as I like ceph-volume and the work being done, is it really a
>>>> good idea to use a minor release to deprecate a tool?
>>>>
>>>> Can't we just introduce ceph-volume and deprecate ceph-disk at the
>>>> release of M? Because when you upgrade to 12.2.2 suddenly existing
>>>> integrations will have deprecation warnings being thrown at them while they
>>>> haven't upgraded to a new major version.
>>>
>>>
>>> ceph-volume has been present since the very first release of Luminous,
>>> the deprecation warning in ceph-disk is the only "new" thing
>>> introduced for 12.2.2.
>>
>>
>> I think Wido's question still stands: why can't ceph-disk be deprecated
>> solely in M, and removed by N?
> 
> Like I mentioned, I don't think this is set in stone (yet), but it was
> the idea from the beginning (See Oct 9th thread "killing ceph-disk"),
> and I don't think it would
> be terribly bad to keep ceph-disk in Mimic, but fully frozen, with no
> updates or bug fixes. And full removal in N
> 
> The deprecation warnings need to stay for Luminous though.

I can live with this, granted Luminous still sees bug fixes despite the 
deprecation warning - but I'm guessing that's what you meant by only 
fully freezing in Mimic :).

Thanks.

   -Joao
