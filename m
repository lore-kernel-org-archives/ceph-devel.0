From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [PATCH] mon:  use first_commited instead of latest_full map if
 latest_bl.length() == 0
Date: Fri, 19 Jul 2013 22:26:05 +0200
Message-ID: <51E9A0DD.8090102@profihost.ag>
References: <1374222696-7100-1-git-send-email-s.priebe@profihost.ag> <51E93700.1040908@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:53183 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992Ab3GSUZ6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jul 2013 16:25:58 -0400
In-Reply-To: <51E93700.1040908@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

sorry as all my mons were down with the same error - i was in a hurry=20
made sadly no copy of the mons and workaround by hack ;-( but i posted =
a=20
log to pastebin with debug mon 20. (see last email)

Stefan

Mit freundlichen Gr=FC=DFen
   Stefan Priebe
Bachelor of Science in Computer Science (BSCS)
Vorstand (CTO)

-------------------------------
Profihost AG
Am Mittelfelde 29
30519 Hannover
Deutschland

Tel.: +49 (511) 5151 8181     | Fax.: +49 (511) 5151 8282
URL: http://www.profihost.com | E-Mail: info@profihost.com

Sitz der Gesellschaft: Hannover, USt-IdNr. DE813460827
Registergericht: Amtsgericht Hannover, Register-Nr.: HRB 202350
Vorstand: Cristoph Bluhm, Sebastian Bluhm, Stefan Priebe
Aufsichtsrat: Prof. Dr. iur. Winfried Huck (Vorsitzender)

Am 19.07.2013 14:54, schrieb Joao Eduardo Luis:
> On 07/19/2013 09:31 AM, Stefan Priebe wrote:
>> this fixes a failure like:
>>       0> 2013-07-19 09:29:16.803918 7f7fb5f31780 -1 mon/OSDMonitor.c=
c:
>> In function 'virtual void OSDMonitor::update_from_paxos(bool*)' thre=
ad
>> 7f7fb5f31780 time 2013-07-19 09:29:16.803439
>> mon/OSDMonitor.cc: 132: FAILED assert(latest_bl.length() !=3D 0)
>>
>>   ceph version 0.61.5-15-g72c7c74
>> (72c7c74e1f160e6be39b6edf30bce09b770fa777)
>>   1: (OSDMonitor::update_from_paxos(bool*)+0x16e1) [0x51d121]
>>   2: (PaxosService::refresh(bool*)+0xe6) [0x4f2a46]
>>   3: (Monitor::refresh_from_paxos(bool*)+0x57) [0x48f7b7]
>>   4: (Monitor::init_paxos()+0xe5) [0x48f955]
>>   5: (Monitor::preinit()+0x679) [0x4b1cf9]
>>   6: (main()+0x36b0) [0x484bb0]
>>   7: (__libc_start_main()+0xfd) [0x7f7fb408dc8d]
>>   8: /usr/bin/ceph-mon() [0x4801e9]
>>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
>> ---
>>   src/mon/OSDMonitor.cc |    6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/src/mon/OSDMonitor.cc b/src/mon/OSDMonitor.cc
>> index 9c854cd..ab3b8ec 100644
>> --- a/src/mon/OSDMonitor.cc
>> +++ b/src/mon/OSDMonitor.cc
>> @@ -129,6 +129,12 @@ void OSDMonitor::update_from_paxos(bool
>> *need_bootstrap)
>>     if ((latest_full > 0) && (latest_full > osdmap.epoch)) {
>>       bufferlist latest_bl;
>>       get_version_full(latest_full, latest_bl);
>> +
>> +    if (latest_bl.length() =3D=3D 0 && latest_full !=3D 0 &&
>> get_first_committed() > 1) {
>
> latest_full is always > 0 here, following the previous if check.
>
>> +        dout(0) << __func__ << " latest_bl.length() =3D=3D 0 use
>> first_commited instead of latest_full" << dendl;
>> +        latest_full =3D get_first_committed();
>> +        get_version_full(latest_full, latest_bl);
>> +    }
>>       assert(latest_bl.length() !=3D 0);
>>       dout(7) << __func__ << " loading latest full map e" <<
>> latest_full << dendl;
>>       osdmap.decode(latest_bl);
>>
>
> Although appreciated, this patch fixes the symptom leading to the cra=
sh.
>   The bug itself seems to be that there is a latest_full version that=
 is
> empty.  Until we know for sure what is happening and what is leading =
to
> such state, fixing the symptom is not advisable, as it is not only
> masking the real issue but it may also have unforeseen long-term effe=
cts.
>
> Stefan, do you still have the store state on which this was triggered=
?
> If so, can you share it with us (or dig a bit into it yourself if you
> can't share the store, in which case I'll let you know what to look f=
or).
>
>    -Joao
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
