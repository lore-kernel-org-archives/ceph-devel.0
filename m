From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re:
	=?gb2312?b?tPC4tDogIEhvdyBsb25nIHdpbGwgdGhlIGxvZ3Mg?=
	=?gb2312?b?YmUga2VwdD8=?=
Date: Thu, 3 Dec 2015 07:21:01 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512030719360.19170@cobra.newdream.net>
References: <47D132BF400BE64BAE6D71033F7D3D75030E7B67@H3CMLB12-EX.srv.huawei-3com.com>
	<CABAwU-bNERLVaAgF_tJ8WFJ-eH3zvVO6zdU-7CQSB1wTh8EYJQ@mail.gmail.com>
	<47D132BF400BE64BAE6D71033F7D3D75030E7C02@H3CMLB12-EX.srv.huawei-3com.com>
	<37396A32-183A-45B5-A86B-6FC0C0939930@schermer.cz>
	<47D132BF400BE64BAE6D71033F7D3D75030E7CCF@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <47D132BF400BE64BAE6D71033F7D3D75030E7CCF-JwQOC20i6vT3cnzPNjVLboSsE/coCuR8pWgKQ6/u3Fg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Wukongming <wu.kongming-vVzyEvZLFYE@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, huang jun <hjwsm1989-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 3 Dec 2015, Wukongming wrote:
> OK! One more question. Do you know why ceph has 2 ways outputting 
> logs(dout && clog). Cause I find dout is more helpful than clog, Did 
> ceph use clog first, and dout added for new version?

clog is the 'cluster log', that gets aggregated into a single log stream 
and replicated on each monitor (normally /var/log/ceph/ceph.log). It's for 
high-level events of interest to the entire cluster.  The intended 
consumer is the system administrator.

dout is for debugging a single process.  It's used by a developer (or a 
savvy admin).

sage
