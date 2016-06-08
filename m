From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: un-even data filled on OSDs
Date: Wed, 8 Jun 2016 10:39:46 +0530
Message-ID: <CANA9Uk5Ks1KT+Osb7QW8uLtbAG57ZYF=qj6cR7bLG7XVXAjWjw@mail.gmail.com>
References: <CANA9Uk4NH7H4kQjEzeNp26bvar5DRWvnNdPff-wCJDRfb1be_A@mail.gmail.com>
	<alpine.DEB.2.11.1606070830160.6221@cpach.fuggernut.com>
	<CANA9Uk6YXFpAyp+jUgq7Cc9nRwR4Ha=UO-0nPrEAxy8A_GxGNA@mail.gmail.com>
	<alpine.DEB.2.11.1606070905590.6221@cpach.fuggernut.com>
	<CANA9Uk7aQrom4HEWJHSUjJeY7ywK8KZ0pmdsoY6dwHf4HhPBWg@mail.gmail.com>
	<CA+z5DsznXSZQ2TQ9y3D0rj-fU4Yi=8GNOW89ZmwvHkvQada4cg@mail.gmail.com>
	<CANA9Uk7rNtfLrO+oT8XbfxaRdX0psPmcRHcNOKYvQ0UCrTGc=g@mail.gmail.com>
	<CA+z5DsxrovFX6GGmcfWAhNm69fb3s4-M6wMSR1u5vzdV8LTSSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+z5DsxrovFX6GGmcfWAhNm69fb3s4-M6wMSR1u5vzdV8LTSSg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Thats great.. Will try this..

Thanks
Swami

On Wed, Jun 8, 2016 at 10:38 AM, Blair Bethwaite
<blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> It runs by default in dry-run mode, which IMHO opinion should be the
> default for operations like this. IIRC you add "-d -r" to make it
> actually apply the re-weighting.
>
> Cheers,
>
> On 8 June 2016 at 15:04, M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Blair - Thanks for the script...Btw, is this script has option for dry run?
>>
>> Thanks
>> Swami
>>
>> On Wed, Jun 8, 2016 at 6:35 AM, Blair Bethwaite
>> <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> Swami,
>>>
>>> Try https://github.com/cernceph/ceph-scripts/blob/master/tools/crush-reweight-by-utilization.py,
>>> that'll work with Firefly and allow you to only tune down weight of a
>>> specific number of overfull OSDs.
>>>
>>> Cheers,
>>>
>>> On 7 June 2016 at 23:11, M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>> OK, understood...
>>>> To fix the nearfull warn, I am reducing the weight of a specific OSD,
>>>> which filled >85%..
>>>> Is this work-around advisable?
>>>>
>>>> Thanks
>>>> Swami
>>>>
>>>> On Tue, Jun 7, 2016 at 6:37 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
>>>>> On Tue, 7 Jun 2016, M Ranga Swami Reddy wrote:
>>>>>> Hi Sage,
>>>>>> >Jewel and the latest hammer point release have an improved
>>>>>> >reweight-by-utilization (ceph osd test-reweight-by-utilization ... to dry
>>>>>> > run) to correct this.
>>>>>>
>>>>>> Thank you....But not planning to upgrade the cluster soon.
>>>>>> So, in this case - are there any tunable options will help? like
>>>>>> "crush tunable optimal" or so?
>>>>>> OR any other configuration options change will help?
>>>>>
>>>>> Firefly also has reweight-by-utilization... it's just a bit less friendly
>>>>> than the newer versions.  CRUSH tunables don't generally help here unless
>>>>> you have lots of OSDs that are down+out.
>>>>>
>>>>> Note that firefly is no longer supported.
>>>>>
>>>>> sage
>>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>> Thanks
>>>>>> Swami
>>>>>>
>>>>>>
>>>>>> On Tue, Jun 7, 2016 at 6:00 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
>>>>>> > On Tue, 7 Jun 2016, M Ranga Swami Reddy wrote:
>>>>>> >> Hello,
>>>>>> >> I have aorund 100 OSDs in my ceph cluster. In this a few OSDs filled
>>>>>> >> with >85% of data and few OSDs filled with ~60%-70% of data.
>>>>>> >>
>>>>>> >> Any reason why the unevenly OSDs filling happned? do I need to any
>>>>>> >> tweaks on configuration to fix the above? Please advise.
>>>>>> >>
>>>>>> >> PS: Ceph version is - 0.80.7
>>>>>> >
>>>>>> > Jewel and the latest hammer point release have an improved
>>>>>> > reweight-by-utilization (ceph osd test-reweight-by-utilization ... to dry
>>>>>> > run) to correct this.
>>>>>> >
>>>>>> > sage
>>>>>> >
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>> --
>>> Cheers,
>>> ~Blairo
>
>
>
> --
> Cheers,
> ~Blairo
