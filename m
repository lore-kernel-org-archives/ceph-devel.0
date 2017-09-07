From: Adrian Saul <Adrian.Saul-c0gOmZ191bzdje4Cb2DbcYdd74u8MsAO@public.gmane.org>
Subject: Re: Ceph release cadence
Date: Thu, 7 Sep 2017 06:07:42 +0000
Message-ID: <81cc12b5a7624e86b7fd4e94b3545c65@tpgtelecom.com.au>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1709061523170.16664-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org" <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

> * Drop the odd releases, and aim for a ~9 month cadence. This splits the
> difference between the current even/odd pattern we've been doing.
>
>   + eliminate the confusing odd releases with dubious value
>   + waiting for the next release isn't quite as bad
>   - required upgrades every 9 months instead of ever 12 months

As a user is probably closest to the ideal, although a production deployment might slip out of the LTS view in 18 months given once deployed they tend to stay static.

From a testing perspective it would be good to know you could deploy the "early access" version of a release and test with that rather than having to switch release to productionise when that release is blessed.

Also, and this might be harder to achieve, but could krbd support for new releases be more aligned with kernel versions?  Or at the least a definitive map of what kernels and backports support which release.


Confidentiality: This email and any attachments are confidential and may be subject to copyright, legal or some other professional privilege. They are intended solely for the attention and use of the named addressee(s). They may only be copied, distributed or disclosed with the consent of the copyright owner. If you have received this email by mistake or by breach of the confidentiality clause, please notify the sender immediately by return email and delete or destroy all copies of the email. Any confidentiality, privilege or copyright is not waived or lost because this email has been sent to you by mistake.
