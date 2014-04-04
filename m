From: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Ceph User Committee monthly meeting #1 : executive
	summary
Date: Fri, 4 Apr 2014 12:23:03 -0700
Message-ID: <CAPYLRzg0RP1PdTpK-9-2mMvNuK3e_tP0RnFsMSDhE+VExnOpFQ@mail.gmail.com>
References: <533EDF0E.70409@dachary.org>
	<CANP1eJENd3rOSRweAo6+a785h8sgOSixGszyrtvDbBemf8-Ukw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANP1eJENd3rOSRweAo6+a785h8sgOSixGszyrtvDbBemf8-Ukw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Milosz Tanski <milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Apr 4, 2014 at 11:15 AM, Milosz Tanski <milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org> wrote:
> Loic,
>
> The writeup has been helpful.
>
> What I'm curious about (and hasn't been mentioned) is can we use
> erasure with CephFS? What steps have to be taken in order to setup
> erasure coding for CephFS?

Lots. CephFS takes advantage of almost every RADOS capability, and EC
pools support only a subset of that. We haven't even whiteboarded what
would be required at this time. If using a cache pool is a feasible
option that would be a lot easier, but we haven't evaluated it yet.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com

>
> In our case we'd like to take advantage of the savings since a large
> chunk of our data is written once, read many times, after a while
> seldom accessed. It looks like by default MDS alredy sets default
> pools for data and metadata. So I'm guessing this requires some
> preparation in advance.
>
> Best,
> - Milosz
>
> On Fri, Apr 4, 2014 at 12:34 PM, Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org> wrote:
>> Hi Ceph,
>>
>> This month Ceph User Committee meeting was about:
>>
>>     Tiering, erasure code
>>     Using http://tracker.ceph.com/
>>     CephFS
>>     Miscellaneous
>>
>> You will find an executive summary at:
>>
>>    https://wiki.ceph.com/Community/Meetings/Ceph_User_Committee_meeting_=
2014-04-03
>>
>> The full log of the IRC conversation is also included to provide more co=
ntext when needed. Feel free to edit if you see a mistake.
>>
>> Cheers
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
>
>
>
> --
> Milosz Tanski
> CTO
> 10 East 53rd Street, 37th floor
> New York, NY 10022
>
> p: 646-253-9055
> e: milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
