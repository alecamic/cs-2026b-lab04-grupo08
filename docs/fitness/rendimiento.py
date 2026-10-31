import random, heapq, statistics

def simular_catalogo(lam=16, workers=4, tiempo_base=0.15, usa_cache=False, tasa_acierto=0.85, segundos=120):
    rnd = random.Random(42)
    t, llegadas = 0.0, []
    while t < segundos:
        t += rnd.expovariate(lam)
        llegadas.append(t)
    
    libres = [0.0] * workers
    heapq.heapify(libres)
    respuestas = []
    
    for a in llegadas:
        libre = heapq.heappop(libres)
        inicio = max(a, libre)
        # Si usa caché y acierta, la respuesta es inmediata (5ms)
        if usa_cache and rnd.random() < tasa_acierto:
            duracion = 0.005
        else:
            duracion = rnd.lognormvariate(random.lognormvariate(-2.0, 0.2), tiempo_base)
        fin = inicio + duracion
        heapq.heappush(libres, fin)
        respuestas.append((fin - a) * 1000)
        
    respuestas.sort()
    return {"p95": respuestas[int(len(respuestas) * 0.95)]}
