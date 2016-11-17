From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Build Warnings: spotting them, and cleaning them up
Date: Thu, 17 Nov 2016 01:33:52 +0100
Message-ID: <62187186-0daa-89d3-7116-51aa1aeca545@digiware.nl>
References: <CAJ4mKGa6ECp6Qdy9jU2fF_NWONKZp=hviTyN68LXvw94J9Fd9w@mail.gmail.com>
 <20161116221018.GA8507@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGbUhfi5SA5UKNN_rZbPZ=eHHLohjzJeiy4qr+0sDg=7Eg@mail.gmail.com>
 <20161116222935.GB8507@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGZdmR++4PDKGOnyS7kHf9PUzKms_gVaChtjEbhoj+EO0Q@mail.gmail.com>
 <715cd198-a7e4-9ae7-cf04-f973669c22a9@digiware.nl>
 <alpine.DEB.2.11.1611170015250.12110@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:43455 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751652AbcKQAd6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 16 Nov 2016 19:33:58 -0500
In-Reply-To: <alpine.DEB.2.11.1611170015250.12110@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 17-11-2016 01:15, Sage Weil wrote:
> On Thu, 17 Nov 2016, Willem Jan Withagen wrote:
>> On 16-11-2016 23:33, Gregory Farnum wrote:
>>> On Wed, Nov 16, 2016 at 2:29 PM, Adam C. Emerson <aemerson@redhat.com> wrote:
>>>> On 16/11/2016, Gregory Farnum wrote:
>>>>> Is that branch going to merge imminently? If not maybe we could pull
>>>>> out this and the BlueStore fixes for fast merging. :)
>>>>
>>>> It is in wip-sage-testing at the moment.
>>>>
>>>>> Is this different from the boost changes you mentioned you already
>>>>> have? :)
>>>>
>>>> Yes and no. The boost changes fix everything in external dependencies
>>>> I know about. I was just pointing out that we shouldn't have trouble
>>>> addressing future problems if they crop up.
>>>
>>> Okay, so once your stuff is in we ought to be able to add -Werr to the
>>> build flags. Hurray!
>>
>> 'mmmm,
>>
>> Perhaps you can fix the CMakeList.txt such that ATM it is only set for
>> Linux/GCC....
>>
>> I'm all for it, and there is already quite some work done to get the
>> code to pass with CLANG.
>> But you are going to rain a bit on my parade in getting up to running
>> all tests successful and getting to a milestone for the port to FreeBSD.
>> Due to execluding some code for FreeBSD, I end up with quite a few more
>> unused errors. So I'll have to start fixing them as well.
>>
>> Perhaps it would be possible to have jenkins test compilation with Clang
>> on Linux, since otherwise my port is the only thing that is going to
>> catch Clang warnings. And it is not always easy to get those fixed if
>> you are not into the changed code.
> 
> Once the clang build is working I'd love to have a clang build test!

I would not hold my breath, but we are slowly getting there.

For the code I'm compiling atm. there are remaining 3 problems for me,
and I haven't looked real hard into either one.

1) A illegal access in unittest_denc where seemingly an incorrect offset
is used. I just ignore the test result ATM

2) test/test_mempool.cc:
//   {
//     mempool::unittest_2::map<int,obj> v;
//     v[1] = obj();
//     v[2] = obj(2);
//     v[3] = obj(2, 3);
//   }
// }

And
// TEST(mempool, unordered_map)
// {
//   mempool::unittest_2::unordered_map<int,obj> h;
//   h[1] = obj();
//   h[2] = obj(1);
// }

And here Clang complains about not matching types for the 2 components
during the compare function.
I just patch the code to not compile the code.

3) msg/async/AsyncMessenger.cc
  in Processor::rebind
-  return bind(addr, new_avoid);
+  return bind(msgr->my_inst.addr, new_avoid);

If I do not replace that reference, I end up with nonce mismatches once
connections have restarted. Doing this seemingly equivalent replacement
fixes that.

--WjW



