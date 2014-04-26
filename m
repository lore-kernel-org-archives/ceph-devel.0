From: Luke Jing Yuan <jyluke-YhiXQ1Q1pWA@public.gmane.org>
Subject: Re: Ceph mds laggy and failed assert in
	function	replay mds/journal.cc
Date: Sat, 26 Apr 2014 05:10:10 +0000
Message-ID: <E0E280CCE0E1A44898C992A9190D929A5AAFE0@MBX02-TPM.mimos.local>
References: <20DBB415DF55354C8FC7AF12F4AE7700132C91@MBX02-TPM.mimos.local>
	<CAPYLRzj2WdT4dGzh+LJ7fNwT4kiSg3ZHoM0ZpdyWG_uat6Qz3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAPYLRzj2WdT4dGzh+LJ7fNwT4kiSg3ZHoM0ZpdyWG_uat6Qz3w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>, Mohd Bazli Ab Karim <bazli.abkarim-YhiXQ1Q1pWA@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

HI Greg,

Actually the cluster that my colleague and I is working is rather new and still have plenty of space left (less than 7% used). What we noticed just before the MDS gave us this problem, was a temporary network issue in the data center so we are not sure that could have been the root cause.

Anyway, how may we create an empty sessionmap?

Regards,
Luke

-----Original Message-----
From: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of Gregory Farnum
Sent: Saturday, 26 April, 2014 2:02 AM
To: Mohd Bazli Ab Karim
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Subject: Re: [ceph-users] Ceph mds laggy and failed assert in function replay mds/journal.cc

Hmm, it looks like your on-disk SessionMap is horrendously out of date. Did your cluster get full at some point?

In any case, we're working on tools to repair this now but they aren't ready for use yet. Probably the only thing you could do is create an empty sessionmap with a higher version than the ones the journal refers to, but that might have other fallout effects...
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Fri, Apr 25, 2014 at 2:57 AM, Mohd Bazli Ab Karim <bazli.abkarim-YhiXQ1Q1pWA@public.gmane.org> wrote:
> More logs. I ran ceph-mds  with debug-mds=20.
>
> -2> 2014-04-25 17:47:54.839672 7f0d6f3f0700 10 mds.0.journal
> -2> EMetaBlob.replay inotable tablev 4316124 <= table 4317932
> -1> 2014-04-25 17:47:54.839674 7f0d6f3f0700 10 mds.0.journal
> -1> EMetaBlob.replay sessionmap v8632368 -(1|2) == table 7239603
> -1> prealloc [1000041df86~1] used 1000041db9e
>   0> 2014-04-25 17:47:54.840733 7f0d6f3f0700 -1 mds/journal.cc: In
> function 'void EMetaBlob::replay(MDS*, LogSegment*, MDSlaveUpdate*)'
> thread 7f0d6f3f0700 time 2014-04-25 17:47:54.839688 mds/journal.cc:
> 1303: FAILED assert(session)
>
> Please look at the attachment for more details.
>
> Regards,
> Bazli
>
> From: Mohd Bazli Ab Karim
> Sent: Friday, April 25, 2014 12:26 PM
> To: 'ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> Subject: Ceph mds laggy and failed assert in function replay
> mds/journal.cc
>
> Dear Ceph-devel, ceph-users,
>
> I am currently facing issue with my ceph mds server. Ceph-mds daemon does not want to bring up back.
> Tried running that manually with ceph-mds -i mon01 -d but it shows that it stucks at failed assert(session) line 1303 in mds/journal.cc and aborted.
>
> Can someone shed some light in this issue.
> ceph version 0.72.2 (a913ded2ff138aefb8cb84d347d72164099cfd60)
>
> Let me know if I need to send log with debug enabled.
>
> Regards,
> Bazli
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
