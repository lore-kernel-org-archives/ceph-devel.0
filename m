From: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: ceph-disk is now deprecated
Date: Tue, 28 Nov 2017 07:52:17 -0500
Message-ID: <CAC-Np1ynRyeOChGK2k_oBAx0A7XcAFkMDMrxVHZhN-pjGXfAJw@mail.gmail.com>
References: <CAC-Np1z7OJNxUeso+FEB8g+7RUABkvKF58_mmXDHt4SeOTHSDw@mail.gmail.com>
 <1821337488.5487.1511856776936@ox.pcextreme.nl>
 <CAC-Np1zfMoqtW2M75ZAys1_NTEkns6MJ6HimuRR3nFhbMVzjPg@mail.gmail.com>
 <1db3fa50-d022-bf37-eb4b-098882ea0984@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1db3fa50-d022-bf37-eb4b-098882ea0984-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Joao Eduardo Luis <joao-l3A5Bk7waGM@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Nov 28, 2017 at 7:38 AM, Joao Eduardo Luis <joao-l3A5Bk7waGM@public.gmane.org> wrote:
> On 11/28/2017 11:54 AM, Alfredo Deza wrote:
>>
>> On Tue, Nov 28, 2017 at 3:12 AM, Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org> wrote:
>>>
>>>
>>>> Op 27 november 2017 om 14:36 schreef Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
>>>>
>>>>
>>>> For the upcoming Luminous release (12.2.2), ceph-disk will be
>>>> officially in 'deprecated' mode (bug fixes only). A large banner with
>>>> deprecation information has been added, which will try to raise
>>>> awareness.
>>>>
>>>
>>> As much as I like ceph-volume and the work being done, is it really a
>>> good idea to use a minor release to deprecate a tool?
>>>
>>> Can't we just introduce ceph-volume and deprecate ceph-disk at the
>>> release of M? Because when you upgrade to 12.2.2 suddenly existing
>>> integrations will have deprecation warnings being thrown at them while they
>>> haven't upgraded to a new major version.
>>
>>
>> ceph-volume has been present since the very first release of Luminous,
>> the deprecation warning in ceph-disk is the only "new" thing
>> introduced for 12.2.2.
>
>
> I think Wido's question still stands: why can't ceph-disk be deprecated
> solely in M, and removed by N?

Like I mentioned, I don't think this is set in stone (yet), but it was
the idea from the beginning (See Oct 9th thread "killing ceph-disk"),
and I don't think it would
be terribly bad to keep ceph-disk in Mimic, but fully frozen, with no
updates or bug fixes. And full removal in N

The deprecation warnings need to stay for Luminous though.

>
> I get that it probably seems nuts to support ceph-disk and ceph-volume; and
> by deprecating and removing in (less than) a full release cycle will force
> people to actually move from one to the other. But we're also doing it when
> roughly 4 months away from Mimic being frozen.
>
> This is the sort of last minute overall, core, changes that are not expected
> from a project that should be as mature as Ceph. This is not some internal
> feature that users won't notice - we're effectively changing the way users
> deploy and orchestrate their clusters.
>
>
>   -Joao
