From: Sindre Stene <sindrestene@gmail.com>
Subject: Re: Substriping support in ErasureCodeInterface
Date: Fri, 5 Jun 2015 15:34:15 +0200
Message-ID: <CAA-SLH_EZbe=S=GVdPaQj6Bz0gPE1qDqKGUuUdHyQGPy4JT7hA@mail.gmail.com>
References: <CAA-SLH9NNinYZO2iev5nYnTfR+va73-UNh7GnwAroSjtxCot0Q@mail.gmail.com>
	<557198A7.5040805@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36260 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbbFENeQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jun 2015 09:34:16 -0400
Received: by igbpi8 with SMTP id pi8so15650240igb.1
        for <ceph-devel@vger.kernel.org>; Fri, 05 Jun 2015 06:34:15 -0700 (PDT)
In-Reply-To: <557198A7.5040805@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Sending the mail again without pesky html tags.

On Fri, Jun 5, 2015 at 2:40 PM, Loic Dachary <loic@dachary.orgwrote:
>(...)
>Why do you think the current interface is insufficient ? What would you
>need in addition ?

I am not sure whether or not the interface is sufficient. Let me try to
explain my assumptions, so that we can clarify.

Lets say for the sake of simplicity that I have a system of 14 HDDs, with an
allocation unit size of 4K, and am using K = 10 systematic drives, and M = 4
redundancy drives (and no spares).
Lets say that I am using an encoding scheme with 8 substripes (for each of
the 14 stripes), and only one object size, that perfectly matches the
scheme: 4K * 10 * 8. My raw objects are then of 80 chunks, and i am adding
32 chunks of redundancy data, making each encoded object take up 4K*8*14 =
448K. The chunks are to be physically stored with these offsets:
HDD0: chunks 0-7
HDD1: chunks 8-15
(...)
HDD13 (redundancy 3): chunks
Assuming that the coding scheme is MDS, the encoding scheme would guarantee
recovery of up to 4 lost hard drives. It would not guarantee recovery for 32
arbitrary chunks (which is the same data amount when considering a single
object), as they would have to be organized in adjacent groups of 8.
Assuming the crush map may be used to configure this sort of chunk
placement, perhaps the interface is indeed sufficient ?

And, not specific to the interface definition, but about how Ceph uses the
interface during operation and during tests:
Would the interface receive decode requests for sets of chunks that are not
organized in groups of 8?
Would the subpacketization (or grouping of chunks) create problems with the
unit tests?
Do you experts see any other implications or side-effects?

Motivation; The required read access for recovering one drive in a (14 total
disks,10 systematic data disks) setup using Reed.Solomon, is 10. This can
theoretically be reduced by ~40% by introducing substripes (splitting each
of the 14 parts into many smaller parts, but fundamentally storing the first
10 major parts in exactly the same way on the HDD, meaning that the I/O of
normal reads are not impacted at all). There are many trade-offs to
consider, and so we wish to test the performance differences.


Sincerely,
Sindre B. Stene
