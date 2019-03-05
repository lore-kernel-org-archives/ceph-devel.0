From: Manuel Lausch <manuel.lausch-JIpuZCKxcH8@public.gmane.org>
Subject: Re: chown -R on every osd activating
Date: Tue, 5 Mar 2019 11:19:36 +0100
Message-ID: <20190305111936.470e041a@lxmlausch2>
References: <20190305105119.676ed92b@lxmlausch2>
 <CAD9yTbGAe3Bxis-Ac9YLf1rXYfBMbpDOCCTa=4B8Jyh3Lpwe3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAD9yTbGAe3Bxis-Ac9YLf1rXYfBMbpDOCCTa=4B8Jyh3Lpwe3A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, 5 Mar 2019 11:04:16 +0100
Paul Emmerich <paul.emmerich-iZXOWb+A65A@public.gmane.org> wrote:

> On Tue, Mar 5, 2019 at 10:51 AM Manuel Lausch
> <manuel.lausch-JIpuZCKxcH8@public.gmane.org> wrote:
> > Now after rebooting a host I see there is a chown -R ceph:ceph
> > running on each OSD before the OSD daemon starts.
> >
> > This takes a lot of time (-> millions of objects per OSD) and I
> > think this is unneccessary on each startup. In my opinion chowning
> > was a case with the update from hammer to jewel.
> >
> > I found this commit:
> > https://github.com/ceph/ceph/commit/100f2613a4659b3bd4e550250a41593860118010
> >
> > Is this intentional or is there a check missing if chown is
> > realy neccessary?  
> 
> This is clearly a bug; it should either have the recursive=False
> parameter set or explicitly chown the necessary files.
> I think it should be the former.
> 
> Please open an issue at http://tracker.ceph.com/
> 

Thanks. There is the ticket: http://tracker.ceph.com/issues/38581
