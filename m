From: Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: ceph s3 allowed characters
Date: Fri, 30 Aug 2013 07:59:39 -0700
Message-ID: <CABBk=J8Jvkchj6JoY560u-mew2qLmBWsLwdnG3-p6s+Gu7fnfg@mail.gmail.com>
References: <CAMNMNTxn3DCbVAnvY1K7PE7Z1oWy-4nM_XKT92+xYEBxKzd=Yg@mail.gmail.com>
	<CANtztVysF7AbZiMimU1zhyBPu35+xQhSvUU+PNRDb42ro2uhng@mail.gmail.com>
	<CAMNMNTyUucZ2ZZu_KwfX2mz77Zx45Lf1j9xRYRNDJWdgF1LkPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAMNMNTyUucZ2ZZu_KwfX2mz77Zx45Lf1j9xRYRNDJWdgF1LkPw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Aug 30, 2013 at 7:44 AM, Dominik Mostowiec
<dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> (echo -n 'GET /dysk/files/test.test%40op.pl/DOMIWENT%202013/Damian%20DW/dw/Specyfikacja%20istotnych%20warunk%F3w%20zam%F3wienia.doc
> HTTP/1.0'; printf "\r\n\r\n") | nc localhost 88
> HTTP/1.1 400 Bad Request
> Date: Fri, 30 Aug 2013 14:10:07 GMT
> Server: Apache/2.2.22 (Ubuntu)
> Accept-Ranges: bytes
> Content-Length: 83
> Connection: close
> Content-Type: application/xml
>
> <?xml version="1.0"
> encoding="UTF-8"?><Error><Code>InvalidObjectName</Code></Error>
>


The object name needs to be utf8 encoded.

Yehuda
