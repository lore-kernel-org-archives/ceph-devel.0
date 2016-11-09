From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Seeking help in getting run-tox-ceph-detect-init to work.
Date: Wed, 9 Nov 2016 10:41:13 +0100
Message-ID: <7df47593-c520-745a-1fb8-196f26f7fa39@digiware.nl>
References: <6a74274e-4134-183c-f8fa-a180b5a93783@digiware.nl>
 <CAJE9aOOj-A-kkBzjyOei7JHRY=qRmT_fVF9L7M_wFyypMKvoBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:25672 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751095AbcKIJlU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 9 Nov 2016 04:41:20 -0500
In-Reply-To: <CAJE9aOOj-A-kkBzjyOei7JHRY=qRmT_fVF9L7M_wFyypMKvoBQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 9-11-2016 09:17, kefu chai wrote:
> On Wed, Nov 9, 2016 at 6:57 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi,
>>
>> I'm looking for a developer with more Python experience....
>> Especially with getting things thru tox.
>>
>> I was able to add FreeBSD support to ceph-detect-init in #11829. But
>> then that is tested in run-tox-detect-init. Which now fails in a Linux
>> Jenkins run:
>> https://jenkins.ceph.com/job/ceph-pull-requests/13621/consoleFull#124607955c19247c4-fcb7-4c61-9a5d-7e2b9731c678
>>
>> But that heavily depends on mock and variations on
>> platform.linux_distribution(), which is over my head.
>>
>> Like:
>>     def test_get(self):
>>         g = ceph_detect_init.get
>>        with mock.patch('platform.linux_distribution',
>>                         lambda **kwargs: (('unknown', '', ''))):
>>             self.assertRaises(exc.UnsupportedPlatform, g)
>>
>> Which hits the assert because linux_distribution() returns
>>         (' ', ' ', ' ')
>> and the system info needs to be extracted from other functions.
>>
>> The brutal way would be to override this test, but the question then is
>> with what? Because there is no one function that returns the required
>> values. So the code would be a copy from what is in the _init_.py code.
>>
>> And that feels like a butcher testing his own meat.
> 
> yes, you need to mock some methods get called in
> platform_information(), please see the updated patch at:
> https://github.com/tchaikov/ceph/commit/fced2823c311bee2be0d226759809fc10170a6ff
> 
> in which, i also added a test for unsupported system.

Cool,

I sort of understand the code, and indeed you are copying the working
code from the module.

But this what it delivers.

--WjW

 =================================== FAILURES
===================================
13: _________________________ TestCephDetectInit.test_get
__________________________
13: NOTE: Incompatible Exception Representation, displaying natively:
13:
13: _StringException: Traceback (most recent call last):
13:   File
"/usr/srcs/Ceph/work/ceph/src/ceph-detect-init/tests/test_all.py", line
155, in test_get
13:     self.assertRaises(exc.UnsupportedPlatform, g)
13:   File
"/usr/srcs/Ceph/work/ceph/src/ceph-detect-init/.tox/py27/lib/python2.7/site-packages/testtools/testcase.py",
line 485, in assertRaises
13:     self.assertThat(our_callable, matcher)
13:   File
"/usr/srcs/Ceph/work/ceph/src/ceph-detect-init/.tox/py27/lib/python2.7/site-packages/testtools/testcase.py",
line 498, in assertThat
13:     raise mismatch_error
13: testtools.matchers._impl.MismatchError: <function get at
0x8089b1500> returned <module 'ceph_detect_init.freebsd' from
'/usr/srcs/Ceph/work/ceph/src/ceph-detect-init/ceph_detect_init/freebsd/__init__.pyc'>
13:
13:
13: _________________ TestCephDetectInit.test_platform_information
_________________
13: NOTE: Incompatible Exception Representation, displaying natively:
13:
13: _StringException: Traceback (most recent call last):
13:   File
"/usr/srcs/Ceph/work/ceph/src/ceph-detect-init/tests/test_all.py", line
234, in test_platform_information
13:     ceph_detect_init.platform_information())
13:   File
"/usr/srcs/Ceph/work/ceph/src/ceph-detect-init/.tox/py27/lib/python2.7/site-packages/testtools/testcase.py",
line 411, in assertEqual
13:     self.assertThat(observed, matcher, message)
13:   File
"/usr/srcs/Ceph/work/ceph/src/ceph-detect-init/.tox/py27/lib/python2.7/site-packages/testtools/testcase.py",
line 498, in assertThat
13:     raise mismatch_error
13: testtools.matchers._impl.MismatchError: ('debian', '6.0', 'squeeze')
!= ('freebsd', '12.0-CURRENT', 'r306554M:')
13:
13:
13: _________________________ TestCephDetectInit.test_run
__________________________
13: NOTE: Incompatible Exception Representation, displaying natively:
13:
13: _StringException: Traceback (most recent call last):
13:   File
"/usr/srcs/Ceph/work/ceph/src/ceph-detect-init/tests/test_all.py", line
262, in test_run
13:     self.assertRaises(exc.UnsupportedPlatform, main.run, argv)
13:   File
"/usr/srcs/Ceph/work/ceph/src/ceph-detect-init/.tox/py27/lib/python2.7/site-packages/testtools/testcase.py",
line 485, in assertRaises
13:     self.assertThat(our_callable, matcher)
13:   File
"/usr/srcs/Ceph/work/ceph/src/ceph-detect-init/.tox/py27/lib/python2.7/site-packages/testtools/testcase.py",
line 498, in assertThat
13:     raise mismatch_error
13: testtools.matchers._impl.MismatchError: <function run at
0x8089b17d0> returned 0
13:

--WjW


