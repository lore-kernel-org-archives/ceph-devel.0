From: Sage Weil <sweil@redhat.com>
Subject: Re: Building for Clang is broken for snap-types
Date: Fri, 21 Oct 2016 22:18:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610212216590.3288@piezo.us.to>
References: <0e42917f-707d-a5a2-141a-6c5c971ff021@digiware.nl> <CAJE9aOP7gYJzgZaT25bJy1y8nOS8Hqmmb0wttc63KN+hg=AoTA@mail.gmail.com> <d2873553-7338-dc43-c98d-2ce0e6a7c956@digiware.nl> <13220e29-4827-c2c9-5c88-0f4a88c2c244@digiware.nl>
 <1dd0cd11-aa96-5d53-5623-bfe856ffd6ff@digiware.nl> <CAJ4mKGbAjqUR1HNEm88e3ZO+Px64Gz+2aVqMq0jkJGCU--xrYg@mail.gmail.com> <4c6e85cd-00f2-2bc3-3ed9-17d136b40b62@digiware.nl> <alpine.DEB.2.11.1610211348470.3288@piezo.us.to> <e8965c6a-e92f-128a-7e89-ebb74cf7a817@digiware.nl>
 <alpine.DEB.2.11.1610211428490.3288@piezo.us.to> <8ceed00c-b67b-977a-8212-716f38cca78a@digiware.nl> <0d9473fb-6775-fa0f-4d3b-33ad8cda019f@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754732AbcJUWSn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 21 Oct 2016 18:18:43 -0400
In-Reply-To: <0d9473fb-6775-fa0f-4d3b-33ad8cda019f@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Gregory Farnum <gfarnum@redhat.com>, kefu chai <tchaikov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 21 Oct 2016, Willem Jan Withagen wrote:
> On 21-10-2016 16:59, Willem Jan Withagen wrote:
> > On 21-10-2016 16:32, Sage Weil wrote:
> >> On Fri, 21 Oct 2016, Willem Jan Withagen wrote:
> >>> On 21-10-2016 15:53, Sage Weil wrote:
> >>>> On Fri, 21 Oct 2016, Willem Jan Withagen wrote:
> >>>>> On 20-10-2016 18:53, Gregory Farnum wrote:
> >>>>>> On Thu, Oct 20, 2016 at 3:21 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> >>>>>>> On 20-10-2016 02:49, Willem Jan Withagen wrote:
> >>>>>>>> On 20-10-2016 02:21, Willem Jan Withagen wrote:
> >>>>>>>>> On 19-10-2016 20:58, kefu chai wrote:
> >>>>>>>>>> should have been fixed in master.
> >>>>>>>>>
> >>>>>>>>> Ehh,
> >>>>>>>>>
> >>>>>>>>> Not really.
> >>>>>>>>> Just tested by running
> >>>>>>>>> cd Ceph/master/ceph
> >>>>>>>>> git pull
> >>>>>>>>> ./do_freebsd.sh
> >>>>>>>>>
> >>>>>>>>> And I still get the same error.
> >>>>>>>>>
> >>>>>>>>> Guess I'll have to start bisecting to see where it went wrong.
> >>>>>>>>
> >>>>>>>> This is the actual commit going wrong
> >>>>>>>>
> >>>>>>>> commit c9c5235ef7d563b92f44dab63a8ac2b694e69d4f
> >>>>>>>> Author: Sage Weil <sage@redhat.com>
> >>>>>>>> Date:   Wed Sep 14 13:32:20 2016 -0400
> >>>>>>>>
> >>>>>>>>     include/object: conditional denc_traits for snapid_t
> >>>>>>>>
> >>>>>>>>     Signed-off-by: Sage Weil <sage@redhat.com>
> >>>>>>>
> >>>>>>> This all was in pull #11027
> >>>>>>> Last commit that works is: dec0f05288dc4fce0f5ae2de7cf4dd8f9281fe1f
> >>>>>>>
> >>>>>>> That code is changing all kind of templates... And to be honest, I not
> >>>>>>> very comfortable with that.
> >>>>>>>
> >>>>>>> But obviously GCC seems to able to promote type
> >>>>>>>         'const vector<snapid_t>'
> >>>>>>> in such a way that it can find a matching function, where as Clang is
> >>>>>>> being more selective (as usual)
> >>>>>>
> >>>>>> That's odd; isn't snapid_t a typedef for uint64_t?
> >>>>>> There are a few things like that which are wrapped structs with
> >>>>>> implicit conversions, in which case maybe it needs to be defined more
> >>>>>> clearly for Clang in this case, or just give it an explicit template
> >>>>>> wrapper pointing at le64 (or whichever one it's supposed to be).
> >>>>>
> >>>>> The other value I see being used in dencode is indeed ceph_le64.
> >>>>>
> >>>>> Although I understand what you are saying. It is not something that I
> >>>>> can just pull out of my hat, since templates still are a large learning
> >>>>> field for me.
> >>>>>
> >>>>> So a hint would be appreciated.
> >>>>
> >>>> It looks like clang is buggy.  At leasy, my fedora 23 version is
> >>>
> >>> Hi Sage,
> >>>
> >>> I do not exclude that....
> >>> It is going to be either buggy of picky. :)
> >>>
> >>>> $ clang --version
> >>>> clang version 3.7.0 (tags/RELEASE_370/final)
> >>>> Target: x86_64-redhat-linux-gnu
> >>>> Thread model: posix
> >>>
> >>> I'm already at 3.8.0 because that is the default compiler for
> >>> 11.0-RELEASE and futher.
> >>>
> >>>> This fixes the snapid_t compilation:
> >>>>
> >>>> diff --git a/src/include/denc.h b/src/include/denc.h
> >>>> index 59f7686..caa095b 100644
> >>>> --- a/src/include/denc.h
> >>>> +++ b/src/include/denc.h
> >>>> @@ -722,7 +722,7 @@ struct denc_traits<
> >>>>  template<typename T>
> >>>>  struct denc_traits<
> >>>>    std::vector<T>,
> >>>> -  typename std::enable_if<denc_traits<T>::supported>::type> {
> >>>> +  typename std::enable_if<denc_traits<T>::supported != 0>::type> {
> >>>>    typedef denc_traits<T> traits;
> >>>>  
> >>>>    enum { supported = true };
> >>>> @@ -831,7 +831,7 @@ struct denc_traits<
> >>>>  template<typename T>
> >>>>  struct denc_traits<
> >>>>    std::set<T>,
> >>>> -  typename std::enable_if<denc_traits<T>::supported>::type> {
> >>>> +  typename std::enable_if<denc_traits<T>::supported != 0>::type> {
> >>>>    typedef denc_traits<T> traits;
> >>>>  
> >>>>    enum { supported = true };
> >>>>
> >>>> which, AFAICS, is nonsense... supported is either a bool or int, and in 
> >>>> either case "supported" and "supported != 0" should be equivalent 
> >>>> (right?).  But once I get past that clang crashes a few files later... see 
> >>>> attached.
> >>>>
> >>>> Maybe start by trying to upgrade clang?  Or submit a clang bug report? :/
> >>>
> >>> I'll see if I can get that somewhere reported as bug since it also
> >>> hampers 3.8.0 .... Probably one of the tool-chain people will know.
> >>>
> >>>> (Perhaps you can use gcc for the time being?)
> >>>
> >>> Don't need to!! 8=) since 3.8.0 takes it without crash.
> >>> Some at least something improved in this corner of the compiler.
> >>>
> >>> But I owe you (lots of) beer, next time we meet...
> >>>
> >>> Going to check if it now completes all the way thru.
> >>
> >> Even if it does, we shouldn't start celebrating yet!  Those are just the 
> >> two cases I had to change to make it get past that one error.  But if the 
> >> template enable_if conditions aren't properly evaluating bool and/or int 
> >> values then I doubt the code is compiling with the correct behavior.
> >>
> >> There is some weirdness here because in some denc_traits instances 
> >> supported = a bool and sometimes support = an int.  It doesn't seem like 
> >> that should prevent determining if the value is true vs non-zero, 
> >> though.  :/
> > 
> > Yup, found that out the "hard" way just right now.
> > On the other hand Clang is rather picky in parameter matching as we
> > found out, so I'd expect it to complain even more if it cannot find to
> > appropriate function signature. Not quite sure if it would then actually
> > compile wrong code?
> > 
> > Was already mailing the freebsd-toolchain guy that has been helpful thus
> > far to see what he suggests we do.
> > The ports collection contains 3.8.1 or 3.8.0_1, and clang-devel which
> > has tag: 3.8.d20150720, not sure how they number the revisions for
> > FreeBSD. And if anything like this is "fixed".
> > 
> > I'll get either told it is a bug and will be fixed. or to "fix the code"
> > if it is a GCC liberty.
> > 
> > For the moment I fixed the other references in denc.h that use
> > 'supported' without comparison, and the code seems to be compiling...
> > 
> > I guess tests will show fast enough, since it should complete the full
> > testset with the exception of ceph-disk.
> 
> What I understand from the Clang guys is that libstdc++ probably has a
> template that takes enable_if() to accept things other than bool. Not
> quite sure why conversion is not automated. On the other hand are all
> examples that I encounter really for boll results.
> Even in cases where extra templates are created like:
> ====
> template <typename>
> struct is_64_bit
> {
>     static const bool value = sizeof(void*) == 8;
> };
> 
> template <typename T>
> typename enable_if<is_64_bit<T>::value, void>::type
> my_memcpy(void* target, const void* source, T n)
> {
>     cout << "64 bit memcpy" << endl;
> }
> ====
> Perhaps that is a possible solution here as well:
> 	is_supported_{0,1,2}
> ???

That makes some sense, I guess.  For now, I think this is a minimal fix to 
avoid the issue:

	https://github.com/ceph/ceph/pull/11605

Can you try it?

(Also, I see there are a bunch of other concerning warnings we should 
fix... mostly improper use of std::move.  When I get back from ODS maybe 
I'll upgrade to fedora 24, get a less-crashy clang, and try using it for a 
while.)

sage

> 
> Testing the fixes I currently have there is only one failure, and even
> that is an expected one:
> 98% tests passed, 2 tests failed out of 130
> 
> Total Test time (real) = 3576.02 sec
> 
> The following tests FAILED:
>          12 - run-tox-ceph-disk (Failed)
>          32 - unittest_denc (SEGFAULT)
> Errors while running CTest
> 
> --WjW
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
