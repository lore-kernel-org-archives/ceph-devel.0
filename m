From: Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Fwd: if ceph tracker says the source was QA,
 what version that I have to checkout?
Date: Mon, 10 Oct 2016 10:18:00 +1000
Message-ID: <20161010001800.GA6044@rskikr.localdomain>
References: <CAJ+86MN1GkiO1coWEXeEkKxmijKRL8zEvszeXPpa-Ky4vXfxSA@mail.gmail.com>
	<CAJ+86MOjgonJk-x9CfucTYy-+UTr16qU3J_9Y1hf0SdozZkZUQ@mail.gmail.com>
	<CAF-wwdG8AEqQJZqhpJb74Y5h-T7i_TZBsb+aYstyha3UhmrYmQ@mail.gmail.com>
	<CAJ+86MMy8K+obb-ywoC+a9_gBgqXJkozbzs7hpvquC4bJa=OCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJ+86MMy8K+obb-ywoC+a9_gBgqXJkozbzs7hpvquC4bJa=OCA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: agung Laksono <agung.smarts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org



On Mon, Oct 10, 2016 at 9:51 AM, agung Laksono <agung.smarts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> thank you for the answer Brad,
>
> so the thing that I have to do is that:
> - see the commit version
> - checkout to the commit version
> - see the log ( git log -p -1)
> - ultimately, checkout the older one.
>
> Am I correct?

Yes, that's pretty much it. The following should be your starting point.

$ git checkout c421b55e8e15ef04ca8aeb47f7d090375eaa8573~1

It's not guaranteed that every commit will build and test successfully so you
may need to move further back from that point or even use the previous tag (in
this case v0.85).

>
>
> On Mon, Oct 10, 2016 at 6:28 AM, Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>
>> On Mon, Oct 10, 2016 at 9:21 AM, agung Laksono <agung.smarts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> wrote:
>> >
>> > Hi All ceph users,
>> >
>> > I am interesting to learn ceph bug.
>> >
>> > Some bugs that I learned pointing particular ceph version or tags for
>> > their
>> > buggy part.
>> > However I found some bugs put Q/A as the source.
>> > For instance http://tracker.ceph.com/issues/9301
>> >
>> > when I checked out on giant and firefly version, I saw the significant
>> > different between
>> > the version and the revision that changed by the developer.
>> >
>> > My question is how to have a buggy version( version when the patch has
>> > not
>> > been implemented)?
>>
>> For this particular commit we can ask git.
>>
>>
>> http://tracker.ceph.com/projects/ceph/repository/revisions/c421b55e8e15ef04ca8aeb47f7d090375eaa8573
>>
>> $ git describe c421b55e8e15ef04ca8aeb47f7d090375eaa8573
>> v0.85-884-gc421b55
>>
>> So this was the 884th commit after the v0.85 tag and you need to check
>> out a copy of the source before that.
>>
>> >
>> > Thanks
>> >
>> > --
>> > Cheers,
>> >
>> > Agung Laksono
>> >
>> > _______________________________________________
>> > ceph-users mailing list
>> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> >
>>
>>
>>
>> --
>> Cheers,
>> Brad
>
>
>
>
> --
> Cheers,
>
> Agung Laksono
>



-- 
Cheers,
Brad
