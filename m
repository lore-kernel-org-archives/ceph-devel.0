From: Luke Jing Yuan <jyluke-YhiXQ1Q1pWA@public.gmane.org>
Subject: Re: Ceph mds laggy and failed assert in
	function	replay mds/journal.cc
Date: Tue, 29 Apr 2014 07:43:02 +0000
Message-ID: <E0E280CCE0E1A44898C992A9190D929A5ABC15@MBX02-TPM.mimos.local>
References: <20DBB415DF55354C8FC7AF12F4AE7700132C91@MBX02-TPM.mimos.local>
	<CAPYLRzj2WdT4dGzh+LJ7fNwT4kiSg3ZHoM0ZpdyWG_uat6Qz3w@mail.gmail.com>
	<CAEDpR-sMb4A3f60DDFewb9Bfu3XbeDP1gcSkSc6iJwCZLOUBxQ@mail.gmail.com>
	<CAAM7YAnQBwj=KSSfATeepbWyhOMAVwfoiC2AvkCEZrdPwkY2Ug@mail.gmail.com>
	<CAEDpR-vBVOqPYnMW=VxnAcPygJBKOvaQaWSrCw3XP9aKQi1MRA@mail.gmail.com>
	<CAAM7YAn5G-sEMOkZY+D4mOSaXbZb6NEx4A11DbRUhdMJfmC_fQ@mail.gmail.com>
	<CAEDpR-vPCAncZ8mDWopuhjC9PmBsxnRMVBDCXCnHEsvSUZSOuQ@mail.gmail.com>
	<CAAM7YAn3499ok-c2=MYfvYqqwEjP3JRj8TXjsSrqnSfttAVgog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAAM7YAn3499ok-c2=MYfvYqqwEjP3JRj8TXjsSrqnSfttAVgog-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: "Yan, Zheng" <ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jingyuan Luke <jyluke-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,

MDS did finish the replay and working after that but we are wondering should we leave the mds_wipe_sessions in ceph.conf or remove it.

Regards,
Luke

-----Original Message-----
From: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of Yan, Zheng
Sent: Tuesday, 29 April, 2014 3:36 PM
To: Jingyuan Luke
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Subject: Re: [ceph-users] Ceph mds laggy and failed assert in function replay mds/journal.cc

On Tue, Apr 29, 2014 at 3:13 PM, Jingyuan Luke <jyluke-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
>
> Assuming we got MDS working back on track, should we still leave the
> mds_wipe_sessions in the ceph.conf or remove it and restart MDS.
> Thanks.

No.

It has been several hours. the MDS still does not finish replaying the journal?

Regards
Yan, Zheng



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
