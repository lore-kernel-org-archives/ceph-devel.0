From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: librados3
Date: Wed, 25 Oct 2017 12:06:09 -0700
Message-ID: <72ed7ce0-4656-7671-8c54-b78b5db0a347@redhat.com>
References: <CAJE9aOPhPFJdV2BQ4-9LhpzN5gucc4BOuU=0C27geK_d0P4r=A@mail.gmail.com>
 <CALe9h7fSc5QoNn49o9MewuLqKc1fST8dR2iq9c3LAPkTij6DJA@mail.gmail.com>
 <CA+aFP1B5TLKDkMEOE9AOLkuNoOq=_mD4jy_MUTo7x2CKXz9LYw@mail.gmail.com>
 <alpine.DEB.2.11.1710191212390.24806@piezo.us.to>
 <CAOtMX2h7r4H0YRr7d-7HWWU9eY7zqQtjW+AtZpHndrG7gwaNkQ@mail.gmail.com>
 <CAF-wwdHpVomqNtJkxaQJm05M17WN=5zJi5owxOOQw3_bgh3zKA@mail.gmail.com>
 <CAJE9aOOdYpepu3O+WUxLv_0kZHc6EB8_gSBTqeunXLRxY1RFQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932221AbdJYTGV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 25 Oct 2017 15:06:21 -0400
In-Reply-To: <CAJE9aOOdYpepu3O+WUxLv_0kZHc6EB8_gSBTqeunXLRxY1RFQg@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, Brad Hubbard <bhubbard@redhat.com>
Cc: Alan Somers <asomers@freebsd.org>, Sage Weil <sweil@redhat.com>, Jason Dillaman <dillaman@redhat.com>, John Spray <jspray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 10/25/2017 01:35 AM, kefu chai wrote:
> thanks for your inputs, guys!
> 
> On Fri, Oct 20, 2017 at 8:15 AM, Brad Hubbard <bhubbard@redhat.com> wrote:
>> On Fri, Oct 20, 2017 at 1:26 AM, Alan Somers <asomers@freebsd.org> wrote:
>>> Would it be possible to use ELF symbol versioning to bump the versions
>>> of all affected functions without bumping the .so number?  That would
>>> provide an upgrade path for distros.  The downside is that the new
>>> librados would need to keep compat shims for old clients.
> 
> we don't release header files and library with versioned symbols at
> least in pre-mimic, so i don't think this approach would help the
> librados client to link against the expected old functions. see the
> output of
> 
> $ objdump -x bin/rados | grep -A42 References
> 
> 
> anyway, thanks to Jason and Sage, we now have a fix for the
> ceph::buffer ABI incompatibility and it's backported to luminous. see
> https://github.com/ceph/ceph/pull/18408. probably we won't have
> librados3 in this release.

The most common culprit for ABI issues is bufferlist since we expose the
internal ceph type directly. This has caused problems with almost every
release lately.

At this point it it seems worth finally separating the internal and
external types there, without doing a full new version of librados.

It may be possible to do this without introducing a new type, by 
freezing the existing bufferlist as the external type for librados and 
librbd, and making a conversion if necessary. We could add a true pimpl 
wrapper as a new type to avoid the overhead of conversion if it is a 
problem.

Josh
