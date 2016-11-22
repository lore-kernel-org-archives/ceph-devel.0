From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Questions about profiling ceph
Date: Tue, 22 Nov 2016 17:05:33 -0600
Message-ID: <fc43040c-54e0-d5f5-3d22-9413153f73f8@redhat.com>
References: <CA+hcxJQQHfhGBHZkfcwn4m3Zfxwh7dPXK=tyVg1d5rw26WNp3g@mail.gmail.com>
 <20161122200037.GD26997@predictor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755609AbcKVXFn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 22 Nov 2016 18:05:43 -0500
In-Reply-To: <20161122200037.GD26997@predictor>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Piotr_Da=c5=82ek?= <branch@predictor.org.pl>, Victor Denisov <vdenisov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 11/22/2016 02:00 PM, Piotr Dałek wrote:
> On Tue, Nov 22, 2016 at 11:42:48AM -0800, Victor Denisov wrote:
>> Hello ceph developers,
>>
>> I'm learning how to profile ceph and came across this page:
>> http://docs.ceph.com/docs/giant/rados/troubleshooting/cpu-profiling/
>>
>> The page suggests to use oprofile. I compiled oprofile version
>> 1.1.0(http://oprofile.sourceforge.net/faq/), but it doesn't have
>> opcontrol binary.
>>
>> Am I doing something wrong? Is it an outdated procedure for profiling?
>> Is there a newer one?
>
> Well, they actually noted (in the faq you linked) that opcontrol is a
> legacy tool. And the cpu profiling guide is for "Giant" Ceph release
> (also quite legacy).
> Anyway, operf + opreport tandem is sufficient for me and I'm sure it
> will be enough for you.
>

I like perf myself:

sudo perf record --call-graph dwarf -F99 -p <ceph daemon pid>
sudo perf report

Mark
