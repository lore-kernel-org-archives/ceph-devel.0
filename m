From: Adam Kupczyk <akupczyk@mirantis.com>
Subject: Re: Improving Data-At-Rest encryption in Ceph
Date: Mon, 18 Jan 2016 09:05:58 +0100
Message-ID: <CAHMeWhHn-8dD_5+1zDizBijwwMZNS7K9ukHk_y_EQQxjKgM88g@mail.gmail.com>
References: <CA+H5UW3DXVm2cQQe5Faw5moeD8jbb9Or5PiN4YJX54Axr-qKYQ@mail.gmail.com>
	<20151215142304.GI31644@suse.de>
	<CAHMeWhFeSTd8w9zjoN1E=3ks7EysziFa_MRxNV4_oua18omRNw@mail.gmail.com>
	<alpine.DEB.2.00.1512161431530.10312@cobra.newdream.net>
	<CAHMeWhHfiakLOJ6BDosXm1P1GDA0TR-pYt+UpZOeQJv4LFYtXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37533 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739AbcARIGA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jan 2016 03:06:00 -0500
Received: by mail-wm0-f41.google.com with SMTP id n5so50309551wmn.0
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jan 2016 00:05:59 -0800 (PST)
In-Reply-To: <CAHMeWhHfiakLOJ6BDosXm1P1GDA0TR-pYt+UpZOeQJv4LFYtXA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Lars Marowsky-Bree <lmb@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi All,

Previously I was making calculations based on assumptions that 25%
operations are write and 75% are read.

Lately I was working on customer's issues on Ceph deployment.
I extracted actual proportions of reads and writes:
pool read     write
X    11.6 G   35.8 G
Y    30.1 G   48.1 G
Z    21.7 G   37.5 G
V    10.6 G    7.0 G
--------------------
sum  74.0 G  130.4 G
     36%      64%

Plugging this into calculations I was using previously, gives us:
1) Dmcrypt:
1*0.36+2.5*0.64*3 = 5.16 bytes of crypto operations per byte of io data.
2) potential inside OSD encryption
1*0.36+1*0.64 = 1 byte of crypto operations per byte of io data.

This further deepens my concern that crypto transformations may be
limit for performance.

Best regards,
Adam Kupczyk

On Mon, Dec 21, 2015 at 9:21 AM, Adam Kupczyk <akupczyk@mirantis.com> wrote:
> On Wed, Dec 16, 2015 at 11:33 PM, Sage Weil <sage@newdream.net> wrote:
>> On Wed, 16 Dec 2015, Adam Kupczyk wrote:
>>> On Tue, Dec 15, 2015 at 3:23 PM, Lars Marowsky-Bree <lmb@suse.com> wrote:
>>> > On 2015-12-14T14:17:08, Radoslaw Zarzynski <rzarzynski@mirantis.com> wrote:
>>> >
>>> > Hi all,
>>> >
>>> > great to see this revived.
>>> >
>>> > However, I have come to see some concerns with handling the encryption
>>> > within Ceph itself.
>>> >
>>> > The key part to any such approach is formulating the threat scenario.
>>> > For the use cases we have seen, the data-at-rest encryption matters so
>>> > they can confidently throw away disks without leaking data. It's not
>>> > meant as a defense against an online attacker. There usually is no
>>> > problem with "a few" disks being privileged, or one or two nodes that
>>> > need an admin intervention for booting (to enter some master encryption
>>> > key somehow, somewhere).
>>> >
>>> > However, that requires *all* data on the OSDs to be encrypted.
>>> >
>>> > Crucially, that includes not just the file system meta data (so not just
>>> > the data), but also the root and especially the swap partition. Those
>>> > potentially include swapped out data, coredumps, logs, etc.
>>> >
>>> > (As an optional feature, it'd be cool if an OSD could be moved to a
>>> > different chassis and continue operating there, to speed up recovery.
>>> > Another optional feature would be to eventually be able, for those
>>> > customers that trust them ;-), supply the key to the on-disk encryption
>>> > (OPAL et al).)
>>> >
>>> > The proposal that Joshua posted a while ago essentially remained based
>>> > on dm-crypt, but put in simple hooks to retrieve the keys from some
>>> > "secured" server via sftp/ftps instead of loading them from the root fs.
>>> > Similar to deo, that ties the key to being on the network and knowing
>>> > the OSD UUID.
>>> >
>>> > This would then also be somewhat easily extensible to utilize the same
>>> > key management server via initrd/dracut.
>>> >
>>> > Yes, this means that each OSD disk is separately encrypted, but given
>>> > modern CPUs, this is less of a problem. It does have the benefit of
>>> > being completely transparent to Ceph, and actually covering the whole
>>> > node.
>>> Agreed, if encryption is infinitely fast dm-crypt is best solution.
>>> Below is short analysis of encryption burden for dm-crypt and
>>> OSD-encryption when using replicated pools.
>>>
>>> Summary:
>>> OSD encryption requires 2.6 times less crypto operations then dm-crypt.
>>
>> Yeah, I believe that, but
>>
>>> Crypto ops are bottleneck.
>>
>> is this really true?  I don't think we've tried to measure performance
>> with dm-crypt, but I also have never heard anyone complain about the
>> additional CPU utilization or performance impact.  Have you observed this?
> I made tests, mostly on my i7-4910MQ 2.9GHz(4 cores) with SSD.
> The results for write were appallingly low, I guess due to kernel
> problems with multi-cpu kcrypto[1]. I will not mention them, these
> results will obfuscate discussion. And newer kernels >4.0.2 do fixes
> the issue.
>
> The results for read were 350MB/s, but CPU utilization was 44% in
> kcrypto kernel worker(single core). This effectively means 11 % of
> total crypto capacity, because intel-optimized AES-NI instruction is
> used almost every cycle, making hyperthreading useless.
>
> [1] http://unix.stackexchange.com/questions/203677/abysmal-general-dm-crypt-luks-write-performance
>>
>> sage
