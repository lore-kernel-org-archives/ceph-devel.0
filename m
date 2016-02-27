From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: ceph + -lssl
Date: Sat, 27 Feb 2016 13:49:08 +0100
Message-ID: <56D19B44.9080005@digiware.nl>
References: <20160224050912.GA6585@degu.b.linuxbox.com>
 <CADRKj5Shu=S4aHX+bz-yw8zuXgGPWE2YE_au5x1HYExwer6HTw@mail.gmail.com>
 <20160227075001.GA21701@degu.b.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:58717 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756183AbcB0Mtb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 27 Feb 2016 07:49:31 -0500
In-Reply-To: <20160227075001.GA21701@degu.b.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Watts <mwatts@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 27-2-2016 08:50, Marcus Watts wrote:
> On Fri, Feb 26, 2016 at 12:43:24PM -0800, Yehuda Sadeh-Weinraub wrote:
>> I rebased these 4 commits on top of a recent master, and here's the
>> new pull request:
>> https://github.com/ceph/ceph/pull/7825
>>
>> On Tue, Feb 23, 2016 at 9:09 PM, Marcus Watts <mwatts@redhat.com> wrote:
>>> I've been working on better integrating ssl int ceph.
> ...
> 
> Thanks Yehuda for doing this.
> 
> Matt pointed out in the pull request that cmake builds were failing
> on this branch.  I've pushed a commit to fix that.

I know I'm not doing the work, but would it be possible to base the work
on for example LibreSSL from OpenBSD or BoringSSL from Google.

From the things I've seen and read about it, these libraries are (good)
attempts to shed a lot of cruft of openssl resulting in a compacter and
better build lib.

Next to the history of OpenBSD which is "not all that bad" for security.
And I'd expect Ceph to only use the more modern parts of the lib, and
thus historical compatibility is not that important here.
--WjW


