From: Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: un-even data filled on OSDs
Date: Thu, 9 Jun 2016 22:20:41 +1000
Message-ID: <CA+z5DszvAcwTO=9smdqjrLWexWGkYmjA0tE6yKVn79ezr0FVmg@mail.gmail.com>
References: <CANA9Uk4NH7H4kQjEzeNp26bvar5DRWvnNdPff-wCJDRfb1be_A@mail.gmail.com>
	<alpine.DEB.2.11.1606070830160.6221@cpach.fuggernut.com>
	<CANA9Uk6YXFpAyp+jUgq7Cc9nRwR4Ha=UO-0nPrEAxy8A_GxGNA@mail.gmail.com>
	<alpine.DEB.2.11.1606070905590.6221@cpach.fuggernut.com>
	<CANA9Uk7aQrom4HEWJHSUjJeY7ywK8KZ0pmdsoY6dwHf4HhPBWg@mail.gmail.com>
	<CA+z5DsznXSZQ2TQ9y3D0rj-fU4Yi=8GNOW89ZmwvHkvQada4cg@mail.gmail.com>
	<CANA9Uk7rNtfLrO+oT8XbfxaRdX0psPmcRHcNOKYvQ0UCrTGc=g@mail.gmail.com>
	<CANA9Uk48oQ7sjd614LzYy=7HxYfmO8qZxoQCC62wYeOdsBPFeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk48oQ7sjd614LzYy=7HxYfmO8qZxoQCC62wYeOdsBPFeg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Swami,

Run it with the help option for more context:
"./crush-reweight-by-utilization.py --help". In your example below
it's reporting to you what changes it would make to your OSD reweight
values based on the default option settings (because you didn't
specify any options). To make the script actually apply those weight
changes you need the "-d -r" or "--doit --really" flags.

If you want to get an idea of the impact that the weight changes will
have before actually starting to move data then I suggest setting
norecover and nobackfill (ceph osd set ...) on your cluster before
making the weight changes, you can then examine "ceph -s" output
(looking at "objects misplaced" to determine the scale of recovery
required. Unset the flags once ready to start or back-out the reweight
settings if you change your mind. You'll also want to lower these
recovery and backfill tunables to reduce impact to client I/O (and if
possible do not do this reweight change during peak I/O hours):
ceph tell osd.* injectargs '--osd-max-backfills 1'
ceph tell osd.* injectargs '--osd-max-recovery-threads 1'
ceph tell osd.* injectargs '--osd-recovery-op-priority 1'
ceph tell osd.* injectargs '--osd-client-op-priority 63'
ceph tell osd.* injectargs '--osd-recovery-max-active 1'

Cheers,

On 9 June 2016 at 20:20, M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Blari,
> I ran the script and results are below:
> ==
> ./crush-reweight-by-utilization.py
> average_util: 0.587024, overload_util: 0.704429, underload_util: 0.587024.
> reweighted:
> 43 (0.852690 >= 0.704429) [1.000000 -> 0.950000]
> 238 (0.845154 >= 0.704429) [1.000000 -> 0.950000]
> 104 (0.827908 >= 0.704429) [1.000000 -> 0.950000]
> 173 (0.817063 >= 0.704429) [1.000000 -> 0.950000]
> ==
>
> is the above scripts says to reweight 43 -> 0.95?
>
> Thanks
> Swami
>
> On Wed, Jun 8, 2016 at 10:34 AM, M Ranga Swami Reddy
> <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
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



-- 
Cheers,
~Blairo
