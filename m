From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: ceph-qa-suite branching (merge it into ceph.git?)
Date: Wed, 13 Apr 2016 12:08:53 -0700
Message-ID: <570E9945.6040401@redhat.com>
References: <CALe9h7fp=qaio8npS0naXjCp9bbg-kkB6bXG9PcGXGftvD4puA@mail.gmail.com>
 <CAKPXa=Y5rJ4ygM9Sdvys+86RwufnKopTOkMNdPHcpCh5bFbQ0w@mail.gmail.com>
 <CALe9h7f3OFobvNscxMTmoSSkxf2PfG71wPqAJ8mTWEBKpGH3Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49409 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932148AbcDMTIz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Apr 2016 15:08:55 -0400
In-Reply-To: <CALe9h7f3OFobvNscxMTmoSSkxf2PfG71wPqAJ8mTWEBKpGH3Dw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Vasu Kulkarni <vakulkar@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, ceph-qa <ceph-qa@ceph.com>

On 04/13/2016 11:46 AM, John Spray wrote:
> On Wed, Apr 13, 2016 at 7:02 PM, Vasu Kulkarni <vakulkar@redhat.com> wrote:
>> we also have s3 suites in its own repo, we have big files in ceph.com/qa
>> which i believe is the right place.
>
> I'm a bit ignorant of the s3 tests, is there a particular reason they
> live separately to the main ceph-qa-suite?

s3 tests are more generic. They run against other s3 implementations,
and only a labeled subset work with rgw.

Josh

