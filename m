From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Re: Messenger issues with Kernel RBD client
Date: Tue, 16 Feb 2016 12:27:04 +0000
Message-ID: <BLUPR0201MB190876C9E03D21DD801BAC85E2AD0@BLUPR0201MB1908.namprd02.prod.outlook.com>
References: <BLUPR0201MB19081EB79465EF9AA20A6FBCE2AD0@BLUPR0201MB1908.namprd02.prod.outlook.com>
 <CAOi1vP9wygdBmFQs8tmr-qn4Es6c+T9u2LOnTVFt7svf3ifyfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0099.outbound.protection.outlook.com ([207.46.100.99]:3616
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754764AbcBPM1H convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Feb 2016 07:27:07 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Sure. will give it try and post all the logs in a shared location.

Thanks,
Varada

On Tuesday 16 February 2016 05:34 PM, Ilya Dryomov wrote:
> On Tue, Feb 16, 2016 at 11:57 AM, Varada Kari <Varada.Kari@sandisk.com> wrote:
>> Hi all,
>>
>> Apologies for the long mail.
>>
>> We are testing the latest jewel branch with kernel RBD in our test
>> clusters. When running some benchmark tests with various tools like
>> vdbench and medusa, we are facing  io's getting timed out and some
>> messenger issues when osd's in a particular node are not reachable(crashed).
>>
>> we simulated the same problem by killing the osds in a specific node.
>> Here is some information about the use case what we are following.
>> please note, steps listed are used for reproducing the problem.
>>
>> [...]
>>
>> Even retires seemed to be replied back to the client, but client is
>> handling the request or not received by the libceph?
>> Enabled logs on libceph end find any handle_reply messages, but they are
>> present in the kernel logs for this tid, except some keep alives been
>> sent to the osd. Have tried with latest stable kernel(4.4.1) to check if
>> any recent fixes resolves the issues, but problem still persists.
> I assume you mean aren't present?  If you have a matching set of osd
> and kernel client logs, please compress and upload them somewhere so
> I can take a look.
>
> Could you try 4.5-rc4?  There is a related fix in 4.5-rc which isn't in
> 4.4.1 (although it's been scheduled for 4.4-stable).  4.5-rc4 would also
> be easier to debug.
>
> Thanks,
>
>                 Ilya
>

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
