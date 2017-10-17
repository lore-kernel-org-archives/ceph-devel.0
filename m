From: Joao Eduardo Luis <joao-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Unstable clock
Date: Tue, 17 Oct 2017 13:50:26 +0100
Message-ID: <ddea6991-ebb5-31bc-7bad-02dc6c8cc89a@suse.de>
References: <085064b4-2e21-4e54-cdd8-dd8a4560aa92@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <085064b4-2e21-4e54-cdd8-dd8a4560aa92-l3A5Bk7waGM@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mohamad Gebai <mgebai-l3A5Bk7waGM@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 10/17/2017 01:30 PM, Mohamad Gebai wrote:
> A concern was raised: are there more critical parts of Ceph where a
> clock jumping around might interfere with the behavior of the cluster?
> It would be good to know if there are any, and maybe prepare for them?

cephx and monitor paxos leases come to mind.

   -Joao
