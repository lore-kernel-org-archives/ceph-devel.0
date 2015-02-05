From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: How to notify an object watched by client via ceph
	class API
Date: Thu, 5 Feb 2015 02:26:47 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502050223110.27042@cobra.newdream.net>
References: <CA+U0gVi=kLnWGbb_Ea=xNGLaRdoxhxGW0HPFT9HUACnHZBM_wg@mail.gmail.com>
	<alpine.DEB.2.00.1502050047370.27042@cobra.newdream.net>
	<CA+U0gViptMjQkTvvweVGbpB8R9VNJn4-bS34tjjVc5+is=B0Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+U0gViptMjQkTvvweVGbpB8R9VNJn4-bS34tjjVc5+is=B0Jw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dennis Chen <kernel.org.gnu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 5 Feb 2015, Dennis Chen wrote:
> On Thu, Feb 5, 2015 at 4:51 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > On Thu, 5 Feb 2015, Dennis Chen wrote:
> >> Hello,
> >>
> >> Just as the subject indicated, how can I notify an object watcher
> >> within a class '.so' loaded into osd deamon. I checked the code and
> >> found the below op code defined already:CEPH_OSD_OP_NOTIFY, but this
> >> op code is not used by existing ceph class api, I guest there must be
> >> a simple solution to resolve this if I don't want to make the osd to
> >> play client role the same time.
> >>
> >> Anyone can help me out this?
> >>
> >
> > The watch/notify does not rely on rados classes, e.g.:
> >
> > rados -p rbd create foo
> > rados -p rbd watch foo &
> > rados -p rbd notify foo hello
> >
> > The notify is just a normal librados operation, and most of those can be
> > called from classes, but it normally blocks for some period until the
> > others acknowledge.  If it were wired up in objclass.h you could probably
> > initiate the async notify but there would be no way to check whether it
> > ever arrived, so I'm not sure it would be useful.
> >
> > What are you trying to accomplish?
> >
> > sage
> 
> What I am trying is to design a signaling control mechanism based on
> ceph, so the notify will not be in heavy load(just some event state
> needed to report to the client async). Below is the investigation for
> this question, initialy the result is good as expected except that the
> argement transfering between the client watcher callback function and
> the osd class function, the code snippet:
> 
> Client side--
> 
> void notify_test(uint8_t opcode, uint64_t ver, void *arg)
> {
>     char *str = (char *)arg;
>     printf("get notify:%s\n", str);

You are using the v1 watch/notify API.  If you look at master you'll see 
there is a new watch2 operation that gets more useful arguments, like the 
data payload.  (Actually v1 has the data payload too, but I forget where 
it appears.  You should still probably target v2 though!)

> }
> 
> int main(...)
> {
>    ...
>    strcpy(arg, "notify: from client");
>    err = rados_watch(io, objname, 0, &handle, notify_test, arg);
>    err = rados_exec(io, objname, "devctl", "devctl_op", in,
> strlen(in), out, 128);
>    ...
> }
> 
> OSD side (in the ceph class)--
> int test_class_ext(cls_method_context_t hctx, bufferlist *in, bufferlist *out)
> {
>     int ret;
> 
>     CLS_LOG(0, "+test_class_ext");
>     in->append("input data");
>     out->append("output data");

Note that out content is discarded.  Also, you will never get it, since 
you aren't blocking (and can't inside a class) and won't wait for a reply.  
The "input data" string should get fed to your notify callback on the 
client, though!

>     ReplicatedPG::OpContext **pctx = (ReplicatedPG::OpContext **)hctx;
>     vector<OSDOp> ops(1);
>     ops[0].op.op = CEPH_OSD_OP_NOTIFY;
>     ops[0].indata = *in;
>     ops[0].outdata = *out;

can just leave outdata NULL.

>     ret = (*pctx)->pg->do_osd_ops(*pctx, ops);
>     in->claim(ops[0].indata);

This isn't needed, and might be eating your notify payload?

>     out->claim(ops[0].outdata);

not needed

sage

>     CLS_LOG(0, "ret = %d", ret);
> 
>     return 0;
> }
> 
> static int devctl_op(cls_method_context_t hctx, bufferlist *in, bufferlist *out)
> {
>    ...
>    test_class_ext(hctx, in, out);
>    return 0;
> }
> 
> 
> The output in the client:
> get notify:notify: from client
> 
> 
> I can't pass the parameters to the client watcher currently :( , any hints?
> 
> -- 
> Den
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
