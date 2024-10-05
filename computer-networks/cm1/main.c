#include "stdio.h"

#define V 6
#define INFINITY 99999
#define N 8

int graph[V][V];

int generate_value(int i, int j) {
    int r = i+1;
    int c = j+1;
    if (i == j) {
        return INFINITY;
    }
    return N + 3*r*c;
}

void fill_graph() {
    for (int i = 0; i < V; i++) {
        for (int j = 0; j < V; j++) {
            graph[i][j] = generate_value(i, j);
        }
    }
}

struct mst {
    int visited;
    int key;
    int near;
} MST_Array[V];

void initialize() {
    for (int i = 0; i < V; i++) {
        MST_Array[i].visited = 0;
        MST_Array[i].key = INFINITY;
        MST_Array[i].near = i;
    }

    MST_Array[0].key = 0;
}

void updateNear() {
    for (int v = 0; v < V; v++) {
        int min = INFINITY;
        int minIndex = 0;
        for (int i = 0; i < V; i++) {
            if (MST_Array[i].key < min && MST_Array[i].visited == 0 &&
                MST_Array[i].key != INFINITY) {
                min = MST_Array[i].key;
                minIndex = i;
            }
        }

        MST_Array[minIndex].visited = 1;

        for (int i = 0; i < V; i++) {
            if (graph[minIndex][i] != 0 && graph[minIndex][i] < INFINITY) {
                if (graph[minIndex][i] < MST_Array[i].key) {
                    MST_Array[i].key = graph[minIndex][i];
                    MST_Array[i].near = minIndex;
                }
            }
        }
    }
}

void show() {
    for (int i = 0; i < V; i++) {
        int idx_r = i+1;
        int idx_l = MST_Array[i].near+1;
        if (idx_l == idx_r) {
            continue;
        }
        printf("%d - %d\t%d\n", idx_l, idx_r, graph[i][MST_Array[i].near]);
    }
}

void show_matrix() {
    for (int i = 0; i < V; i++) {
        for (int j = 0; j < V; j++) {
            if (j == V-1)  {
                printf("%d\n", graph[i][j]);
            } else {
                printf("%d ", graph[i][j]);
            }
        }
    }
}

int main() {
    fill_graph();

    printf("Заполненная матрица весов\n");
    show_matrix();

    initialize();
    updateNear();

    printf("Остовная матрица\n");
    show();
    return 0;
}
