From: Mohd Bazli Ab Karim <bazli.abkarim-YhiXQ1Q1pWA@public.gmane.org>
Subject: Re: Ceph mds laggy and failed assert in function
 replay mds/journal.cc
Date: Wed, 30 Apr 2014 07:07:03 +0000
Message-ID: <20DBB415DF55354C8FC7AF12F4AE77001332D7@MBX02-TPM.mimos.local>
References: <20DBB415DF55354C8FC7AF12F4AE7700132C91@MBX02-TPM.mimos.local>
	<CAPYLRzj2WdT4dGzh+LJ7fNwT4kiSg3ZHoM0ZpdyWG_uat6Qz3w@mail.gmail.com>
	<CAEDpR-sMb4A3f60DDFewb9Bfu3XbeDP1gcSkSc6iJwCZLOUBxQ@mail.gmail.com>
	<CAAM7YAnQBwj=KSSfATeepbWyhOMAVwfoiC2AvkCEZrdPwkY2Ug@mail.gmail.com>
	<CAEDpR-vBVOqPYnMW=VxnAcPygJBKOvaQaWSrCw3XP9aKQi1MRA@mail.gmail.com>
	<CAAM7YAn5G-sEMOkZY+D4mOSaXbZb6NEx4A11DbRUhdMJfmC_fQ@mail.gmail.com>
	<CAEDpR-vPCAncZ8mDWopuhjC9PmBsxnRMVBDCXCnHEsvSUZSOuQ@mail.gmail.com>
	<CAAM7YAn3499ok-c2=MYfvYqqwEjP3JRj8TXjsSrqnSfttAVgog@mail.gmail.com>
	<E0E280CCE0E1A44898C992A9190D929A5ABC15@MBX02-TPM.mimos.local>
	<CAAM7YAmUpvrNP1f8zbuaexWqQK6st+yd38-JUOyuUra2ZqgzLA@mail.gmail.com>
	<E0E280CCE0E1A44898C992A9190D929A5ABCAF@MBX02-TPM.mimos.local>
	<20DBB415DF55354C8FC7AF12F4AE77001330FC@MBX02-TPM.mimos.local>
	<CAAM7YAnu3heq6tSp8ceYD5Tk0X9tNpHa2-CDxO8O81uFA1yydw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAAM7YAnu3heq6tSp8ceYD5Tk0X9tNpHa2-CDxO8O81uFA1yydw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "Yan, Zheng" <ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wong Ming Tat <mt.wong-YhiXQ1Q1pWA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Zheng,

Sorry for the late reply. For sure, I will try this again after we completely verifying all content in the file system. Hopefully all will be good.
And, please confirm this, I will set debug_mds=10 for the ceph-mds, and do you want me to send the ceph-mon log too?

BTW, how to confirm that the mds has passed the beacon to mon or not?

Thank you so much Zheng!

Bazli

-----Original Message-----
From: Yan, Zheng [mailto:ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
Sent: Tuesday, April 29, 2014 10:13 PM
To: Mohd Bazli Ab Karim
Cc: Luke Jing Yuan; Wong Ming Tat
Subject: Re: [ceph-users] Ceph mds laggy and failed assert in function replay mds/journal.cc

On Tue, Apr 29, 2014 at 5:30 PM, Mohd Bazli Ab Karim <bazli.abkarim-YhiXQ1Q1pWA@public.gmane.org> wrote:
> Hi Zheng,
>
> The another issue that Luke mentioned just now was like this.
> At first, we ran one mds (mon01) with the new compiled ceph-mds. It works fine with only one MDS running at that time. However, when we ran two more MDSes mon02 mon03 with the new compiled ceph-mds, it started acting weird.
> Mon01 which was became active at first, will have the error and started to respawning. Once respawning happened, mon03 will take over from mon01 as master mds, and replay happened again.
> Again, when mon03 became active, it will have the same error like below, and respawning again. So, it seems to me that replay will continue to happen from one mds to another when they got respawned.
>
> 2014-04-29 15:36:24.917798 7f5c36476700  1 mds.0.server
> reconnect_clients -- 1 sessions
> 2014-04-29 15:36:24.919620 7f5c2fb3e700  0 -- 10.4.118.23:6800/26401
> >> 10.1.64.181:0/1558263174 pipe(0x2924f5780 sd=41 :6800 s=0 pgs=0
> cs=0 l=0 c=0x37056e0).accept peer addr is really
> 10.1.64.181:0/1558263174 (socket is 10.1.64.181:57649/0)
> 2014-04-29 15:36:24.921661 7f5c36476700  0 log [DBG] : reconnect by
> client.884169 10.1.64.181:0/1558263174 after 0.003774
> 2014-04-29 15:36:24.921786 7f5c36476700  1 mds.0.12858 reconnect_done
> 2014-04-29 15:36:25.109391 7f5c36476700  1 mds.0.12858 handle_mds_map
> i am now mds.0.12858
> 2014-04-29 15:36:25.109413 7f5c36476700  1 mds.0.12858 handle_mds_map
> state change up:reconnect --> up:rejoin
> 2014-04-29 15:36:25.109417 7f5c36476700  1 mds.0.12858 rejoin_start
> 2014-04-29 15:36:26.918067 7f5c36476700  1 mds.0.12858
> rejoin_joint_start
> 2014-04-29 15:36:33.520985 7f5c36476700  1 mds.0.12858 rejoin_done
> 2014-04-29 15:36:36.252925 7f5c36476700  1 mds.0.12858 handle_mds_map
> i am now mds.0.12858
> 2014-04-29 15:36:36.252927 7f5c36476700  1 mds.0.12858 handle_mds_map
> state change up:rejoin --> up:active
> 2014-04-29 15:36:36.252932 7f5c36476700  1 mds.0.12858 recovery_done -- successful recovery!
> 2014-04-29 15:36:36.745833 7f5c36476700  1 mds.0.12858 active_start
> 2014-04-29 15:36:36.987854 7f5c36476700  1 mds.0.12858 cluster recovered.
> 2014-04-29 15:36:40.182604 7f5c36476700  0 mds.0.12858
> handle_mds_beacon no longer laggy
> 2014-04-29 15:36:57.947441 7f5c2fb3e700  0 -- 10.4.118.23:6800/26401
> >> 10.1.64.181:0/1558263174 pipe(0x2924f5780 sd=41 :6800 s=2 pgs=156
> cs=1 l=0 c=0x37056e0).fault with nothing to send, going to standby
> 2014-04-29 15:37:10.534593 7f5c36476700  1 mds.-1.-1 handle_mds_map i
> (10.4.118.23:6800/26401) dne in the mdsmap, respawning myself
> 2014-04-29 15:37:10.534604 7f5c36476700  1 mds.-1.-1 respawn
> 2014-04-29 15:37:10.534609 7f5c36476700  1 mds.-1.-1  e: '/usr/bin/ceph-mds'
> 2014-04-29 15:37:10.534612 7f5c36476700  1 mds.-1.-1  0: '/usr/bin/ceph-mds'
> 2014-04-29 15:37:10.534616 7f5c36476700  1 mds.-1.-1  1: '--cluster=ceph'
> 2014-04-29 15:37:10.534619 7f5c36476700  1 mds.-1.-1  2: '-i'
> 2014-04-29 15:37:10.534621 7f5c36476700  1 mds.-1.-1  3: 'mon03'
> 2014-04-29 15:37:10.534623 7f5c36476700  1 mds.-1.-1  4: '-f'
> 2014-04-29 15:37:10.534641 7f5c36476700  1 mds.-1.-1  cwd /
> 2014-04-29 15:37:12.155458 7f8907c8b780  0 ceph version  (), process
> ceph-mds, pid 26401
> 2014-04-29 15:37:12.249780 7f8902d10700  1 mds.-1.0 handle_mds_map
> standby
>
> p/s. we ran ceph-mon and ceph-mds on same servers, (mon01,mon02,mon03)
>
> I sent to you two log files, mon01 and mon03 where the scenario of mon03 have state->standby->replay->active->respawned. And also, mon01 which is now running as active as a single MDS at this moment.
>

After the MDS became ative, it did not send beacon to the monitor. It seems like the MDS was busy doing something else. If this issue still happen, set debug_mds=10 and send the log to me.

Regards
Yan, Zheng

> Regards,
> Bazli
> -----Original Message-----
> From: Luke Jing Yuan
> Sent: Tuesday, April 29, 2014 4:46 PM
> To: Yan, Zheng
> Cc: Mohd Bazli Ab Karim; Wong Ming Tat
> Subject: RE: [ceph-users] Ceph mds laggy and failed assert in function
> replay mds/journal.cc
>
> Hi Zheng,
>
> Thanks for the information. Actually we encounter another issue, in our original setup, we have 3 MDS running (say mon01, mon02 and mon03), when we do the replay/recovery we did it on mon01. After we completed, we restarted the mds again on mon02 and mon03 (without the mds_wipe_sessions and using the patched binary) but there was when we noticed something else, my colleague Mr. Bazli who started the original thread probably can explain a bit more on the observations made.
>
> Regards,
> Luke
>
> -----Original Message-----
> From: Yan, Zheng [mailto:ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Tuesday, 29 April, 2014 4:26 PM
> To: Luke Jing Yuan
> Subject: Re: [ceph-users] Ceph mds laggy and failed assert in function
> replay mds/journal.cc
>
> On Tue, Apr 29, 2014 at 3:43 PM, Luke Jing Yuan <jyluke-YhiXQ1Q1pWA@public.gmane.org> wrote:
>> Hi,
>>
>> MDS did finish the replay and working after that but we are wondering should we leave the mds_wipe_sessions in ceph.conf or remove it.
>>
>
> should disable mds_wipe_sessions after mds starts working
>
>> Regards,
>> Luke
>>
>> -----Original Message-----
>> From: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of Yan, Zheng
>> Sent: Tuesday, 29 April, 2014 3:36 PM
>> To: Jingyuan Luke
>> Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> Subject: Re: [ceph-users] Ceph mds laggy and failed assert in
>> function replay mds/journal.cc
>>
>> On Tue, Apr 29, 2014 at 3:13 PM, Jingyuan Luke <jyluke-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> Hi,
>>>
>>> Assuming we got MDS working back on track, should we still leave the
>>> mds_wipe_sessions in the ceph.conf or remove it and restart MDS.
>>> Thanks.
>>
>> No.
>>
>> It has been several hours. the MDS still does not finish replaying the journal?
>>
>> Regards
>> Yan, Zheng
>>
>>
>>
>> ________________________________
>> DISCLAIMER:
>>
>>
>> This e-mail (including any attachments) is for the addressee(s) only and may be confidential, especially as regards personal data. If you are not the intended recipient, please note that any dealing, review, distribution, printing, copying or use of this e-mail is strictly prohibited. If you have received this email in error, please notify the sender immediately and delete the original message (including any attachments).
>>
>>
>> MIMOS Berhad is a research and development institution under the purview of the Malaysian Ministry of Science, Technology and Innovation. Opinions, conclusions and other information in this e-mail that do not relate to the official business of MIMOS Berhad and/or its subsidiaries shall be understood as neither given nor endorsed by MIMOS Berhad and/or its subsidiaries and neither MIMOS Berhad nor its subsidiaries accepts responsibility for the same. All liability arising from or in connection with computer viruses and/or corrupted e-mails is excluded to the fullest extent permitted by law.
>>
>> ------------------------------------------------------------------
>> -
>> -
>> DISCLAIMER:
>>
>> This e-mail (including any attachments) is for the addressee(s) only
>> and may contain confidential information. If you are not the intended
>> recipient, please note that any dealing, review, distribution,
>> printing, copying or use of this e-mail is strictly prohibited. If
>> you have received this email in error, please notify the sender
>> immediately and delete the original message.
>> MIMOS Berhad is a research and development institution under the
>> purview of the Malaysian Ministry of Science, Technology and
>> Innovation. Opinions, conclusions and other information in this e-
>> mail that do not relate to the official business of MIMOS Berhad
>> and/or its subsidiaries shall be understood as neither given nor
>> endorsed by MIMOS Berhad and/or its subsidiaries and neither MIMOS
>> Berhad nor its subsidiaries accepts responsibility for the same. All
>> liability arising from or in connection with computer viruses and/or
>> corrupted e-mails is excluded to the fullest extent permitted by law.
>>
>>
>
> ________________________________
> DISCLAIMER:
>
>
> This e-mail (including any attachments) is for the addressee(s) only and may be confidential, especially as regards personal data. If you are not the intended recipient, please note that any dealing, review, distribution, printing, copying or use of this e-mail is strictly prohibited. If you have received this email in error, please notify the sender immediately and delete the original message (including any attachments).
>
>
> MIMOS Berhad is a research and development institution under the purview of the Malaysian Ministry of Science, Technology and Innovation. Opinions, conclusions and other information in this e-mail that do not relate to the official business of MIMOS Berhad and/or its subsidiaries shall be understood as neither given nor endorsed by MIMOS Berhad and/or its subsidiaries and neither MIMOS Berhad nor its subsidiaries accepts responsibility for the same. All liability arising from or in connection with computer viruses and/or corrupted e-mails is excluded to the fullest extent permitted by law.
>
>
> ------------------------------------------------------------------
> -
> -
> DISCLAIMER:
>
> This e-mail (including any attachments) is for the addressee(s) only
> and may contain confidential information. If you are not the intended
> recipient, please note that any dealing, review, distribution,
> printing, copying or use of this e-mail is strictly prohibited. If you
> have received this email in error, please notify the sender
> immediately and delete the original message.
> MIMOS Berhad is a research and development institution under the
> purview of the Malaysian Ministry of Science, Technology and
> Innovation. Opinions, conclusions and other information in this e-
> mail that do not relate to the official business of MIMOS Berhad
> and/or its subsidiaries shall be understood as neither given nor
> endorsed by MIMOS Berhad and/or its subsidiaries and neither MIMOS
> Berhad nor its subsidiaries accepts responsibility for the same. All
> liability arising from or in connection with computer viruses and/or
> corrupted e-mails is excluded to the fullest extent permitted by law.
>

________________________________
DISCLAIMER:


This e-mail (including any attachments) is for the addressee(s) only and may be confidential, especially as regards personal data. If you are not the intended recipient, please note that any dealing, review, distribution, printing, copying or use of this e-mail is strictly prohibited. If you have received this email in error, please notify the sender immediately and delete the original message (including any attachments).


MIMOS Berhad is a research and development institution under the purview of the Malaysian Ministry of Science, Technology and Innovation. Opinions, conclusions and other information in this e-mail that do not relate to the official business of MIMOS Berhad and/or its subsidiaries shall be understood as neither given nor endorsed by MIMOS Berhad and/or its subsidiaries and neither MIMOS Berhad nor its subsidiaries accepts responsibility for the same. All liability arising from or in connection with computer viruses and/or corrupted e-mails is excluded to the fullest extent permitted by law.

------------------------------------------------------------------
-
-
DISCLAIMER: 

This e-mail (including any attachments) is for the addressee(s) 
only and may contain confidential information. If you are not the 
intended recipient, please note that any dealing, review, 
distribution, printing, copying or use of this e-mail is strictly 
prohibited. If you have received this email in error, please notify 
the sender  immediately and delete the original message. 
MIMOS Berhad is a research and development institution under 
the purview of the Malaysian Ministry of Science, Technology and 
Innovation. Opinions, conclusions and other information in this e-
mail that do not relate to the official business of MIMOS Berhad 
and/or its subsidiaries shall be understood as neither given nor 
endorsed by MIMOS Berhad and/or its subsidiaries and neither 
MIMOS Berhad nor its subsidiaries accepts responsibility for the 
same. All liability arising from or in connection with computer 
viruses and/or corrupted e-mails is excluded to the fullest extent 
permitted by law.
