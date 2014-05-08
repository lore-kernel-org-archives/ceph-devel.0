From: Daniel Hofmann <daniel@trvx.org>
Subject: Re: A plea for more tooling usage
Date: Thu, 08 May 2014 16:22:52 +0200
Message-ID: <f06db295-6402-4d3b-bdb5-2d0b84d3f434@email.android.com>
References: <20140506134826.GA17004@trvx.org> <alpine.DEB.2.00.1405060816160.28165@cobra.newdream.net> <CANP1eJHnyEP_DALV9ZVF5+h=ridz73g=Gfy1aqhhsE9aUUDyLg@mail.gmail.com> <b29f7e9d-8260-4211-986b-20ed6cc65977@email.android.com> <CANP1eJGK98r-RKrSGZtSOQ17p09=Xr-KnsaNKKywm2g1mBNCPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from trvx.org ([46.38.250.125]:37702 "EHLO mail.trvx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753443AbaEHOXK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 8 May 2014 10:23:10 -0400
In-Reply-To: <CANP1eJGK98r-RKrSGZtSOQ17p09=Xr-KnsaNKKywm2g1mBNCPA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

As I said, I only uploaded the summary.
The reports take around 5 GB of space.

Please run the analyzer yourself for the detailed individual reports.

On May 8, 2014 2:55:28 PM CEST, Milosz Tanski <milosz@adfin.com> wrote:
>Daniel,
>
>It is orthogonal. Having said that I find the issues raised by them of
>higher value (logic errors, bad comparisons) then warnings about
>unused private fields, or various extensions that make the code easier
>to write (0 len array, anon union).
>
>A a side note Daniel it looks like the  links from the report
>frontpage are broken. All the links hard code a uri that points to
>localhost. I believe there's a command line argument to the tool that
>generates static pages (without needing to run their webserver).
>
>Thanks for putting this up,
>- Milosz
>
>On Thu, May 8, 2014 at 7:37 AM, Daniel Hofmann <daniel@trvx.org> wrote:
>> Using the Static Analyzer is orthogonal to enabling more diagnostics.
>>
>> I uploaded my latest report results (only the summary, the specific
>reports take around 5 GB) here:
>>
>>> http://trvx.org/~daniel/ceph-devel/report.html
>>
>> Quite interesting -- hopefully you soon get this from a Jenkins
>build, as discussed on IRC.
>>
>>
>>
>> On May 6, 2014 5:35:00 PM CEST, Milosz Tanski <milosz@adfin.com>
>wrote:
>>>Indeed clangs warnings are much exhaustive. We've also had good
>>>success with static analyzer based on clang
>>>(http://clang-analyzer.llvm.org/). We've found a few logic issues in
>>>our application using it as well... esp. a few bugs that where corner
>>>cases had to due to very specific arguments passed cross function
>(and
>>>back). I don't know how it relates to Coverity is complementary or
>>>more of a replacement.
>>>
>>>In terms of the sanitize settings one has to be careful with which
>>>ones are enabled as some of them (thread sanitizer, memory sanitizer)
>>>give you a pretty big performance hit. Not as bad as valgrind (5x to
>>>20x slowdown) but more like 2x to 5x slowdown. It's best to use to
>>>build specialized debug builds to run through integration testing.
>>>
>>>P.S: Sorry for the dup-email yet again. Ugh @ gmail.
>>>
>>>On Tue, May 6, 2014 at 11:19 AM, Sage Weil <sage@inktank.com> wrote:
>>>> On Tue, 6 May 2014, Daniel Hofmann wrote:
>>>>> Preamble: you might want to read the decent formatted version of
>>>this mail at:
>>>>> > https://gist.github.com/daniel-j-h/06f16015c89bec4fbb42
>>>>>
>>>>>
>>>>> Motivation
>>>>> ----------
>>>>>
>>>>> I tried to build Ceph with the Clang (3.4) compiler. The only
>issue
>>>>> preventing the build to finish was a "VLA of non-POD type" usage
>>>which
>>>>> I fixed here:
>>>>>
>>>>> https://github.com/ceph/ceph/pull/1768
>>>>
>>>> Merged, thanks!
>>>>
>>>> Daniel, this is great.  We've been clean on gcc for a long time but
>I
>>>(at
>>>> least) didn't realize there was a huge set of potentially important
>>>issues
>>>> that clang warns about that gcc does not.  We definitely want to
>>>clean
>>>> these up and get the right set of warnings whitelisted.  Alfredo is
>>>> setting up a jenkins job for this so we can follow it going
>forward,
>>>but
>>>> there is clearly a pretty big initial effort needed to get the
>>>existing
>>>> warnings cleaned up.  If anybody is interested in helping with that
>>>> effort, pull requests are very welcome!  :)
>>>>
>>>> sage
>>>>
>>>>
>>>>>
>>>>> While the build was resuming I was wondering why no one stumpled
>>>upon this
>>>>> issue in the first place. Has nobody ever tried to compile Ceph
>with
>>>Clang?
>>>>>
>>>>> So I did what I'm always doing to quick-check a project's code
>>>quality:
>>>>> I set the compiler to Clang. I set flags to -Weverything.
>>>>>
>>>>> The idea is to gradually disable warnings one by one that are not
>>>interesting.
>>>>>
>>>>> Instead of doing this by hand I used the following flags that I
>>>>> accumulated over the last weeks or month to disable a handful of
>not
>>>so
>>>>> important warnings:
>>>>>
>>>>> > -Weverything -Wno-padded -Wno-c++11-long-long
>-Wno-variadic-macros
>>>>> > -Wno-c++11-extensions -Wno-global-constructors
>>>-Wno-exit-time-destructors
>>>>> > -Wno-sign-conversion -Wno-weak-vtables
>>>-Wno-disabled-macro-expansion
>>>>> > -Wno-c99-extensions -Wno-shadow
>-Wno-documentation-unknown-command
>>>-Wno-undef
>>>>> > -Wno-documentation -Wno-duplicate-enum -Wno-switch-enum
>>>-Wno-unused-parameter
>>>>> > -Wno-packed
>>>>>
>>>>> Let's build Ceph and have a look at what Clang's -Weverything
>>>catches:
>>>>>
>>>>>     ./autogen.sh
>>>>>     ./configure --without-libxfs
>>>>>     make -j 1 2> diagnostics.txt
>>>>>
>>>>> Many warnings are duplicates because of header includes and the
>>>like.
>>>>> Let's remove duplicates and only keep unique diagnostics:
>>>>>
>>>>>     $ egrep "\[-.*\]" diagnostics.txt | sort | uniq > uniq.txt
>>>>>     $ wc -l uniq.txt
>>>>>     12286 uniq.txt
>>>>>
>>>>> Wow. 12286 unique diagnostics. Interested in what showed up?
>>>>>
>>>>>
>>>>> How bad is it
>>>>> -------------
>>>>>
>>>>> I ended up going through the diagnostic categories, because I had
>a
>>>few hours
>>>>> to spare. The methodology I used was the following:
>>>>>
>>>>> Check for diagnostic categories, prioritize them, and after that
>>>remove all
>>>>> the occurences in the original diagnostics file by:
>>>>>
>>>>>     $ sed -i '/Wflag/d' uniq.txt
>>>>>
>>>>> In the following I'll give you a quick summary of the most
>important
>>>>> diagnostics. After this there are still some diagnostics left.
>>>>>
>>>>>     $ wc -l uniq.txt
>>>>>     3362 uniq.txt
>>>>>
>>>>> This can be explained by diagnostics that are not important at
>all,
>>>such as
>>>>> unused exception parameter in a catch clause.
>>>>>
>>>>> But there are also conversions between types that have to be
>studied
>>>one by
>>>>> one to check if a loss in precision or comparison of types with
>>>different
>>>>> signedness could lead to dangerous behavior.
>>>>>
>>>>>
>>>>> Note: Clang's diagnostics can be customized, too:
>>>>>
>>>>>
>>>http://clang.llvm.org/docs/UsersManual.html#formatting-of-diagnostics
>>>>>
>>>>>
>>>>> So let's look through the categories.
>>>>>
>>>>>
>>>>> Undefined Behavior
>>>>> ------------------
>>>>>
>>>>> > warning: 'va_start' has undefined behavior with reference types
>>>[-Wvarargs]
>>>>>
>>>>>     $ grep Wvarargs uniq.txt | wc -l
>>>>>     1
>>>>>
>>>>> Here's the paragraph from the C++11 Standard, 18.10 ?3:
>>>>> > If the parameter parmN is declared with a function, array, or
>>>reference type, or with a type that is not compatible with the type
>>>that results when passing an argument for which there is no
>parameter,
>>>the behavior is undefined.
>>>>>
>>>>> http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2012/n3337.pdf
>>>>>
>>>>>
>>>>> Conditional Uninitialized
>>>>> -------------------------
>>>>>
>>>>> > warning: variable '%' may be uninitialized when used here
>>>[-Wconditional-uninitialized]
>>>>>
>>>>>     $ grep Wconditional-uninitialized uniq.txt | wc -l
>>>>>     4
>>>>>
>>>>>
>>>>> Unreachable Code
>>>>> ----------------
>>>>>
>>>>> > warning: will never be executed [-Wunreachable-code]
>>>>>
>>>>>     $ grep Wunreachable-code uniq.txt | wc -l
>>>>>     155
>>>>>
>>>>>
>>>>> Extensions to the C++ language
>>>>> ------------------------------
>>>>>
>>>>> There's this vast amount of code that is definitely not conforming
>>>to
>>>>> standard C++. Some extensions are used, such as Variable Length
>>>Arrays (VLAs,
>>>>> which were the reason for my issue in the first place), some GCC
>>>specificas.
>>>>>
>>>>> You probably have to decide if you want to go this route or if you
>>>want to do
>>>>> it the portable and standard C++ way.
>>>>>
>>>>> VLAs are a good example where the standard C++ way of doing it is
>in
>>>no way
>>>>> harder to accomplish. See the following explanation:
>>>>>
>>>>> http://clang.llvm.org/compatibility.html#vla
>>>>>
>>>>>
>>>>> > warning: anonymous types declared in an anonymous union are an
>>>extension [-Wnested-anon-types]
>>>>>
>>>>>     $ grep Wnested-anon-types uniq.txt  | wc -l
>>>>>     28
>>>>>
>>>>> > warning: zero size arrays are an extension [-Wzero-length-array]
>>>>>
>>>>>     $ grep Wzero-length-array uniq.txt | wc -l
>>>>>     8134
>>>>>
>>>>> > warning: anonymous structs are a GNU extension
>>>[-Wgnu-anonymous-struct]
>>>>>
>>>>>     $ grep Wgnu-anonymous-struct uniq.txt  | wc -l
>>>>>     2
>>>>>
>>>>> > warning: '%' may not be nested in a struct due to flexible array
>>>member [-Wflexible-array-extensions]
>>>>>
>>>>>     $ grep Wflexible-array-extensions uniq.txt | wc -l
>>>>>     2
>>>>>
>>>>> > warning: variable length array used [-Wvla]
>>>>> > warning: variable length arrays are a C99 feature
>>>[-Wvla-extension]
>>>>>
>>>>>     $ grep Wvla uniq.txt | wc -l
>>>>>     178
>>>>>
>>>>> > warning: cast between pointer-to-function and pointer-to-object
>is
>>>an extension [-Wpedantic]
>>>>> > warning: use of non-standard escape character '\%' [-Wpedantic]
>>>>>
>>>>>     $ grep Wpedantic uniq.txt | wc -l
>>>>>     15
>>>>>
>>>>> > warning: use of GNU old-style field designator extension
>>>[-Wgnu-designator]
>>>>>
>>>>>     $ grep Wgnu-designator uniq.txt | wc -l
>>>>>     43
>>>>>
>>>>> > warning: anonymous unions are a C11 extension [-Wc11-extensions]
>>>>>
>>>>>     $ grep Wc11-extensions uniq.txt | wc -l
>>>>>     3
>>>>>
>>>>>
>>>>> Miscellaneous:
>>>>> --------------
>>>>>
>>>>> > warning: '%' hides overloaded virtual function
>>>[-Woverloaded-virtual]
>>>>>
>>>>>     $ grep Woverloaded-virtual uniq.txt | wc -l
>>>>>     3
>>>>>
>>>>> > warning: using namespace directive in global context in header
>>>[-Wheader-hygiene]
>>>>>
>>>>>     $ grep Wheader-hygiene uniq.txt | wc -l
>>>>>     87
>>>>>
>>>>> > warning: extra ';' after member function definition
>[-Wextra-semi]
>>>>>
>>>>>     $ grep Wextra-semi uniq.txt | wc -l
>>>>>     135
>>>>>
>>>>> > warning: struct '%' was previously declared as a class
>>>[-Wmismatched-tags]
>>>>>
>>>>>     $ grep Wmismatched-tags uniq.txt | wc -l
>>>>>     93
>>>>>
>>>>> > warning: missing field '%' initializer
>>>[-Wmissing-field-initializers]
>>>>>
>>>>>     $ grep Wmissing-field-initializer uniq.txt | wc -l
>>>>>     3
>>>>>
>>>>> > warning: private field '%' is not used [-Wunused-private-field]
>>>>>
>>>>>     $ grep Wunused-private-field uniq.txt | wc -l
>>>>>     11
>>>>>
>>>>> > warning: function '%' could be declared with attribute
>'noreturn'
>>>[-Wmissing-noreturn]
>>>>>
>>>>>     $ grep Wmissing-noreturn uniq.txt | wc -l
>>>>>     23
>>>>>
>>>>> > warning: token pasting of ',' and __VA_ARGS__ is a GNU extension
>>>[-Wgnu-zero-variadic-macro-arguments]
>>>>>
>>>>>     $ grep Wgnu-zero-variadic-macro-arguments uniq.txt | wc -l
>>>>>     4
>>>>>
>>>>>
>>>>>
>>>>> Style
>>>>> -----
>>>>>
>>>>> While fixing my initial VLA issue I skimmed through the relevant
>>>code
>>>>> in src/rgw/rgw_main.cc.
>>>>>
>>>>> What I noticed is that already in this file there's no consistent
>>>style.
>>>>> There's a "using namespace std;" at the top, then in the file
>>>there's an
>>>>> alternate usage between vector<string> and
>std::vector<std::string>.
>>>>>
>>>>> It also seems to me that the memory management is often done by
>>>hand, e.g.
>>>>> in line 377 "string *objs = new string[num_objs];" and later the
>>>"delete []"
>>>>> instead of just using a std::vector<std::string>.
>>>>>
>>>>>
>>>>> Summary
>>>>> -------
>>>>>
>>>>> Using Clang-3.4's -Weverything reveals critical issues.
>>>>>
>>>>> What I hope for Ceph's general code quality is to improve by using
>>>the tools
>>>>> at hand. This means especially:
>>>>>
>>>>> Do the same check with an up to date Clang (that's one of the
>>>reasons I'm not
>>>>> pointing out all the issues or the concrete source code
>positions),
>>>look
>>>>> through them in detail, such as conversions and left-out
>>>diagnostics, and fix
>>>>> as many as critical issues as possible.
>>>>>
>>>>> You probably could even use Clang's -fsanitize flag to check for
>>>issues at runtime.
>>>>>
>>>http://clang.llvm.org/docs/UsersManual.html#controlling-code-generation
>>>>>
>>>>> Also keep in mind that this check was only done on the userspace
>>>code in the
>>>>> ceph/ceph repository.
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Daniel J. Hofmann
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>ceph-devel"
>>>in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

